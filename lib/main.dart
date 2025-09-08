import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const TableTennisScoreApp());
}

class TableTennisScoreApp extends StatelessWidget {
  const TableTennisScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Счет настольного тенниса',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
                textStyle: const TextStyle(fontSize: 32),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ScoreScreen()),
                );
              },
              child: const Text('Играть'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                textStyle: const TextStyle(fontSize: 24),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const PlayersScreen()),
                );
              },
              child: const Text('Список игроков'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class ScoreLogEntry {
  final int player;
  final int delta;
  final DateTime timestamp;
  ScoreLogEntry(this.player, this.delta, [DateTime? ts]) : timestamp = ts ?? DateTime.now();
}

class _ScoreScreenState extends State<ScoreScreen> {
  List<ScoreLogEntry> scoreLog = [];
  List<List<ScoreLogEntry>> savedGames = [];
  List<String> players = [];
  String? selectedPlayer1;
  String? selectedPlayer2;
  String? goalTarget; // '1' или '2'

  int get player1Score => scoreLog.where((e) => e.player == 1).fold(0, (sum, e) => sum + e.delta);
  int get player2Score => scoreLog.where((e) => e.player == 2).fold(0, (sum, e) => sum + e.delta);

  @override
  void initState() {
    super.initState();
    loadPlayers();
    loadSavedGames();
  }

  Future<void> loadPlayers() async {
    final prefs = await SharedPreferences.getInstance();
    final loadedPlayers = prefs.getStringList('players') ?? [];
    setState(() {
      players = loadedPlayers;
      if (players.length >= 2) {
        selectedPlayer1 ??= players[0];
        selectedPlayer2 ??= players[1];
        goalTarget ??= '1';
      } else {
        selectedPlayer1 = null;
        selectedPlayer2 = null;
        goalTarget = null;
      }
    });
  }

  Future<void> loadSavedGames() async {
    final prefs = await SharedPreferences.getInstance();
    final gamesJson = prefs.getStringList('savedGames') ?? [];
    setState(() {
      savedGames = gamesJson.map((game) {
        final list = jsonDecode(game) as List;
        return list.map((e) => ScoreLogEntry(e['player'], e['delta'], DateTime.parse(e['timestamp']))).toList();
      }).toList();
    });
  }

  Future<void> saveCurrentGame() async {
    final prefs = await SharedPreferences.getInstance();
    final game = scoreLog.map((e) => {
      'player': e.player,
      'delta': e.delta,
      'timestamp': e.timestamp.toIso8601String(),
    }).toList();
    final gamesJson = prefs.getStringList('savedGames') ?? [];
    gamesJson.add(jsonEncode(game));
    await prefs.setStringList('savedGames', gamesJson);
    setState(() {
      savedGames.add(List<ScoreLogEntry>.from(scoreLog));
      scoreLog.clear();
    });
  }

  void reset() {
    setState(() {
      scoreLog.clear();
    });
  }

  void addGoal() {
    if (goalTarget == null) return;
    setState(() {
      scoreLog.add(ScoreLogEntry(goalTarget == '1' ? 1 : 2, 1));
    });
  }

  void deleteLogEntry(int index) {
    setState(() {
      scoreLog.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final canPlay = players.length >= 2 && selectedPlayer1 != null && selectedPlayer2 != null && selectedPlayer1 != selectedPlayer2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Счет настольного тенниса'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              scoreColumn(selectedPlayer1 ?? 'Игрок 1', player1Score),
              scoreColumn(selectedPlayer2 ?? 'Игрок 2', player2Score),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: canPlay ? () {
                  setState(() {
                    scoreLog.add(ScoreLogEntry(1, 1));
                  });
                } : null,
                child: Text('Добавить гол (${selectedPlayer1 ?? "Игрок 1"})'),
              ),
              const SizedBox(width: 24),
              ElevatedButton(
                onPressed: canPlay ? () {
                  setState(() {
                    scoreLog.add(ScoreLogEntry(2, 1));
                  });
                } : null,
                child: Text('Добавить гол (${selectedPlayer2 ?? "Игрок 2"})'),
              ),
            ],
          ),
          if (!canPlay)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Добавьте минимум двух игроков и выберите разных игроков для партии!', style: TextStyle(color: Colors.red)),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: saveCurrentGame,
            child: const Text('Сохранить партию'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: scoreLog.isEmpty
                ? const Text('Нет забитых голов')
                : ListView.builder(
                    reverse: true,
                    itemCount: scoreLog.length,
                    itemBuilder: (context, index) {
                      final entry = scoreLog[index];
                      final name = entry.player == 1 ? selectedPlayer1 : selectedPlayer2;
                      return ListTile(
                        title: Text('Гол: $name'),
                        subtitle: Text(entry.timestamp.toLocal().toString().split('.')[0]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteLogEntry(index),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: savedGames.isEmpty
                ? const Text('Нет сохранённых партий')
                : ListView.builder(
                    itemCount: savedGames.length,
                    itemBuilder: (context, index) {
                      final game = savedGames[index];
                      final p1 = game.where((e) => e.player == 1).fold(0, (sum, e) => sum + e.delta);
                      final p2 = game.where((e) => e.player == 2).fold(0, (sum, e) => sum + e.delta);
                      return ListTile(
                        title: Text('Партия ${index + 1}: ${selectedPlayer1 ?? 'Игрок 1'} - $p1, ${selectedPlayer2 ?? 'Игрок 2'} - $p2'),
                        subtitle: Text('Голов: ${game.length}'),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget scoreColumn(String name, int score) {
    return Column(
      children: [
        Text(name, style: const TextStyle(fontSize: 20)),
        Text('$score', style: const TextStyle(fontSize: 48)),
      ],
    );
  }
}

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  List<String> players = [];

  @override
  void initState() {
    super.initState();
    loadPlayers();
  }

  Future<void> loadPlayers() async {
    final prefs = await SharedPreferences.getInstance();
    players = prefs.getStringList('players') ?? [];
    setState(() {});
  }

  Future<void> addPlayer(String name) async {
    if (name.trim().isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    players.add(name);
    await prefs.setStringList('players', players);
    setState(() {});
  }

  void showAddPlayerDialog() {
    String newName = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить игрока'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Имя игрока'),
          onChanged: (value) => newName = value,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              addPlayer(newName);
              Navigator.of(context).pop();
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список игроков')),
      body: players.isEmpty
          ? const Center(child: Text('Нет игроков'))
          : ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(players[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddPlayerDialog,
        child: const Icon(Icons.add),
        tooltip: 'Добавить игрока',
      ),
    );
  }
}
