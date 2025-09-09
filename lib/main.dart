import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'game_state.dart'; // новый модуль с логикой

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

class _ScoreScreenState extends State<ScoreScreen> {
  final GameState game = GameState();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scoreScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    game.loadPlayers().then((_) => setState(() {}));
    game.loadSavedGames().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scoreScrollController.dispose();
    super.dispose();
  }

  void _addGoalAndScroll(int player) {
    game.addGoalToPlayer(player);
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scoreScrollController.hasClients) {
        _scoreScrollController.animateTo(
          _scoreScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final canPlay = game.players.length >= 2 &&
        game.players[0].isNotEmpty &&
        game.players[1].isNotEmpty &&
        game.players[0] != game.players[1];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Матч по'),
            const SizedBox(width: 16),
            DropdownButton<int>(
              value: game.serveSwitchMode,
              items: const [
                DropdownMenuItem(value: 5, child: Text('Через 5 ходов')),
                DropdownMenuItem(value: 2, child: Text('Через 2 хода')),
              ],
              onChanged: game.totalScore == 0
                  ? (v) {
                      game.setServeSwitchMode(v!);
                      setState(() {});
                    }
                  : null,
            ),
          ],
        ),
      ),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            if (event.isControlPressed || event.logicalKey == LogicalKeyboardKey.space) {
              if (canPlay) {
                game.addGoalToPlayer(1);
                setState(() {});
              }
            } else if (event.logicalKey == LogicalKeyboardKey.enter) {
              if (canPlay) {
                game.addGoalToPlayer(2);
                setState(() {});
              }
            }
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Левая сторона: firPlayer
                Column(
                  children: [
                    Text('Игрок ${game.firPlayer + 1}:'),
                    DropdownButton<String>(
                      value: game.players.length > game.firPlayer ? game.players[game.firPlayer] : null,
                      items: game.players.map((player) {
                        return DropdownMenuItem<String>(
                          value: player,
                          child: Text(player),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (game.players.length > game.firPlayer) game.players[game.firPlayer] = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      game.lock = !game.lock;
                    });
                  },
                  child: Icon(
                    game.lock ? Icons.lock : Icons.lock_open,
                    color: game.lock ? Colors.black : Colors.green,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                // Правая сторона: secPlayer
                Column(
                  children: [
                    Text('Игрок ${game.secPlayer + 1}:'),
                    DropdownButton<String>(
                      value: game.players.length > game.secPlayer ? game.players[game.secPlayer] : null,
                      items: game.players.map((player) {
                        return DropdownMenuItem<String>(
                          value: player,
                          child: Text(player),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (game.players.length > game.secPlayer) game.players[game.secPlayer] = value!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Табло и кнопка для firPlayer
                scoreBox(
                  game.players.length > game.firPlayer ? game.players[game.firPlayer] : 'Игрок',
                  game.firPlayer == 0 ? game.player1Score : game.player2Score,
                  onAddGoal: canPlay ? () {
                    _addGoalAndScroll(game.firPlayer + 1);
                  } : null,
                  color: game.greenPlayer == game.firPlayer ? Colors.green : Colors.pink,
                ),
                // Табло и кнопка для secPlayer
                scoreBox(
                  game.players.length > game.secPlayer ? game.players[game.secPlayer] : 'Игрок',
                  game.secPlayer == 0 ? game.player1Score : game.player2Score,
                  onAddGoal: canPlay ? () {
                    _addGoalAndScroll(game.secPlayer + 1);
                  } : null,
                  color: game.greenPlayer == game.secPlayer ? Colors.green : Colors.pink,
                ),
              ],
            ),
            if (!canPlay)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Добавьте минимум двух игроков и выберите разных игроков для партии!', style: TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                await game.saveCurrentGame();
                setState(() {});
              },
              child: const Text('Сохранить партию'),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: game.scoreLog.isEmpty
                  ? const Text('Нет забитых голов')
                  : ListView.builder(
                      reverse: true,
                      controller: _scoreScrollController,
                      itemCount: game.scoreLog.length,
                      itemBuilder: (context, index) {
                        final entry = game.scoreLog[index];
                        String name = 'Игрок';
                        if (entry.player == 1 && game.players.length > 0) {
                          name = game.players[0];
                        } else if (entry.player == 2 && game.players.length > 1) {
                          name = game.players[1];
                        }
                        return ListTile(
                          title: Text('Гол: $name'),
                          subtitle: Text(entry.timestamp.toLocal().toString().split('.')[0]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              game.deleteLogEntry(index);
                              setState(() {});
                            },
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: game.sessionGames.isEmpty
                  ? const Text('Нет сохранённых партий')
                  : ListView.builder(
                      reverse: true,
                      itemCount: game.sessionGames.length,
                      itemBuilder: (context, index) {
                        final gameEntry = game.sessionGames[index];
                        final p1 = gameEntry.where((e) => e.player == 1).fold(0, (sum, e) => sum + e.delta);
                        final p2 = gameEntry.where((e) => e.player == 2).fold(0, (sum, e) => sum + e.delta);
                        final name1 = game.players.length > 0 ? game.players[0] : 'Игрок 1';
                        final name2 = game.players.length > 1 ? game.players[1] : 'Игрок 2';
                        return ListTile(
                          title: Text('Партия ${index + 1}: $name1 - $p1, $name2 - $p2'),
                          subtitle: Text('Голов: ${gameEntry.length}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget scoreBox(String name, int score, {VoidCallback? onAddGoal, Color? color}) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
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
          width: 120,
          height: 60,
          child: ElevatedButton(
            onPressed: onAddGoal,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              textStyle: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            child: const Text('+'),
          ),
        ),
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
  final GameState game = GameState();

  @override
  void initState() {
    super.initState();
    game.loadPlayers().then((_) => setState(() {}));
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
            onPressed: () async {
              setState(() {});
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
      body: game.players.isEmpty
          ? const Center(child: Text('Нет игроков'))
          : ListView.builder(
              itemCount: game.players.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(game.players[index]),
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
