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
  List<List<ScoreLogEntry>> sessionGames = [];
  List<String> players = [];
  String? selectedPlayer1;
  String? selectedPlayer2;
  String? goalTarget; // '1' или '2'

  final ScrollController goalsController = ScrollController();
  final ScrollController gamesController = ScrollController();

  int servingPlayer = 1;
  int serveCount = 0;
  int serveSwitchMode = 5; // 2 или 5

  int get player1Score => scoreLog.where((e) => e.player == 1).fold(0, (sum, e) => sum + e.delta);
  int get player2Score => scoreLog.where((e) => e.player == 2).fold(0, (sum, e) => sum + e.delta);
  int get totalScore => player1Score + player2Score;

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
      // sessionGames пустой при запуске
      sessionGames = [];
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
      sessionGames.add(List<ScoreLogEntry>.from(scoreLog));
      scoreLog.clear();
      servingPlayer = 1;
      serveCount = 0;
      // режим не сбрасываем, остается выбранным
    });
    // Прокрутка списка игр вниз
    await Future.delayed(const Duration(milliseconds: 100));
    if (gamesController.hasClients) {
      gamesController.animateTo(
        gamesController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void reset() {
    setState(() {
      scoreLog.clear();
      servingPlayer = 1;
      serveCount = 0;
      // режим не сбрасываем, остается выбранным
    });
  }

  void swapPlayers() {
    setState(() {
      // Меняем местами выбранных игроков
      final tmp = selectedPlayer1;
      selectedPlayer1 = selectedPlayer2;
      selectedPlayer2 = tmp;
      // Меняем номера подающего
      servingPlayer = 1;
      serveCount = 0;
      // Меняем счет местами
      scoreLog = scoreLog.map((entry) {
        if (entry.player == 1) {
          return ScoreLogEntry(2, entry.delta, entry.timestamp);
        } else if (entry.player == 2) {
          return ScoreLogEntry(1, entry.delta, entry.timestamp);
        }
        return entry;
      }).toList();
    });
  }

  void addGoalToPlayer(int playerNum) {
    setState(() {
      scoreLog.add(ScoreLogEntry(playerNum, 1));
      serveCount++;
      if (serveCount >= serveSwitchMode) {
        swapPlayers();
      }
    });
    // Прокрутка списка голов вниз
    Future.delayed(const Duration(milliseconds: 100), () {
      if (goalsController.hasClients) {
        goalsController.animateTo(
          goalsController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void deleteLogEntry(int index) {
    setState(() {
      scoreLog.removeAt(index);
    });
  }

  @override
  void dispose() {
    goalsController.dispose();
    gamesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canPlay = players.length >= 2 && selectedPlayer1 != null && selectedPlayer2 != null && selectedPlayer1 != selectedPlayer2;
    // Определяем, какой игрок сейчас подает (всегда слева)
    final leftPlayer = selectedPlayer1;
    final rightPlayer = selectedPlayer2;
    final leftScore = player1Score;
    final rightScore = player2Score;
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Режим перехода подачи: '),
              DropdownButton<int>(
                value: serveSwitchMode,
                items: const [
                  DropdownMenuItem(value: 5, child: Text('Через 5 ходов')),
                  DropdownMenuItem(value: 2, child: Text('Через 2 хода')),
                ],
                onChanged: totalScore == 0 ? (v) => setState(() => serveSwitchMode = v!) : null,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Игрок 1: '),
              DropdownButton<String>(
                value: selectedPlayer1,
                items: players.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (v) {
                  if (v == selectedPlayer2 || totalScore > 5) return;
                  setState(() => selectedPlayer1 = v);
                },
              ),
              const SizedBox(width: 24),
              const Text('Игрок 2: '),
              DropdownButton<String>(
                value: selectedPlayer2,
                items: players.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (v) {
                  if (v == selectedPlayer1 || totalScore > 5) return;
                  setState(() => selectedPlayer2 = v);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              scoreBox(leftPlayer ?? 'Игрок 1', leftScore, onAddGoal: canPlay ? () => addGoalToPlayer(1) : null),
              scoreBox(rightPlayer ?? 'Игрок 2', rightScore, onAddGoal: canPlay ? () => addGoalToPlayer(2) : null),
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
                    controller: goalsController,
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
            child: sessionGames.isEmpty
                ? const Text('Нет сохранённых партий')
                : ListView.builder(
                    controller: gamesController,
                    itemCount: sessionGames.length,
                    itemBuilder: (context, index) {
                      final game = sessionGames[index];
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

  Widget scoreBox(String name, int score, {VoidCallback? onAddGoal}) {
    return Container(
      width: 120,
      height: 120,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Center(
              child: Text(
                '$score',
                style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold, letterSpacing: -2),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            height: 40,
            child: ElevatedButton(
              onPressed: onAddGoal,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                textStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              child: const Text('+'),
            ),
          ),
        ],
      ),
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
