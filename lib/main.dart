import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'game_state.dart'; // новый модуль с логикой
import 'player_repository.dart';

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
  final PlayerRepository repository = PlayerRepository();
  List<Player> allPlayers = [];
  final ScrollController _scoreScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    game.loadPlayers().then((_) => setState(() {}));
    _loadPlayers();
  }

  Future<void> _loadPlayers() async {
    allPlayers = await repository.loadAllPlayers();
    // Если в геймстейте нет игроков, и есть хотя бы два активных игрока, инициализируем их
    if (game.players.isEmpty && allPlayers.where((p) => p.isActive).length >= 2) {
      final active = allPlayers.where((p) => p.isActive).map((p) => p.name).toList();
      game.players = [active[0], active[1]];
    }
    setState(() {});
  }

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
    final activePlayers = allPlayers.where((p) => p.isActive).map((p) => p.name).toList();

    // Для второго дропдауна исключаем выбранного первого игрока
    final secOptions = activePlayers.where((name) => name != game.players[game.firPlayer]).toList();
    // canPlay зависит от количества доступных игроков
    final canPlay = activePlayers.length >= 2;

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
            } else if (event.logicalKey == LogicalKeyboardKey.enter) {
              if (canPlay) {
                game.addGoalToPlayer(2);
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
                    activePlayers.isNotEmpty
                        ? DropdownButton<String>(
                            value: game.players[game.firPlayer] ?? activePlayers.first,
                            items: activePlayers.map((player) {
                              return DropdownMenuItem<String>(
                                value: player,
                                child: Text(player, style: const TextStyle(fontSize: 32, color: Colors.black)), // текст черный
                              );
                            }).toList(),
                            onChanged: game.totalScore == 0
                                ? (value) async {
                                    if (value == game.players[game.secPlayer]) return;
                                    await game.addPlayer(game.firPlayer, value!);
                                    if (game.players[game.firPlayer] == value) {
                                      if (secOptions.isNotEmpty) {
                                        await game.addPlayer(game.secPlayer, secOptions.first);
                                      }
                                    }
                                    setState(() {});
                                  }
                                : null,
                            disabledHint: Text(game.players[game.firPlayer] ?? (activePlayers.isNotEmpty ? activePlayers.first : 'Нет игроков'), style: const TextStyle(fontSize: 32, color: Colors.black)),
                            style: const TextStyle(fontSize: 32, color: Colors.black), // текст черный
                            iconSize: 48,
                            itemHeight: 80,
                          )
                        : Text('Нет доступных игроков', style: const TextStyle(fontSize: 24, color: Colors.red)),
                  ],
                ),
                // --- Кнопка обмена игроков над замочком ---
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.swap_horiz),
                      tooltip: 'Поменять игроков местами',
                      iconSize: 24,
                      onPressed: (canPlay && game.totalScore == 0)
                          ? () async {
                              final tmp = game.players[game.firPlayer];
                              await game.addPlayer(game.firPlayer, game.players[game.firPlayer]!);
                              await game.addPlayer(game.secPlayer, tmp!);
                              setState(() {});
                            }
                          : null,
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          game.lock = !game.lock;
                        });
                      },
                      child: Icon(
                        game.lock ? Icons.lock : Icons.lock_open,
                        color: game.lock ? Colors.black : Colors.green,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                // Правая сторона: secPlayer
                Column(
                  children: [
                    secOptions.isNotEmpty
                        ? DropdownButton<String>(
                            value: game.players[game.firPlayer] ?? secOptions.first,
                            items: secOptions.map((player) {
                              return DropdownMenuItem<String>(
                                value: player,
                                child: Text(player, style: const TextStyle(fontSize: 32, color: Colors.black)), // текст черный
                              );
                            }).toList(),
                            onChanged: game.totalScore == 0
                                ? (value) async {
                                    if (value == game.players[game.firPlayer]) return;
                                    await game.addPlayer(game.secPlayer, value!);
                                    setState(() {});
                                  }
                                : null,
                            disabledHint: Text(game.players[game.secPlayer] ?? (secOptions.isNotEmpty ? secOptions.first : 'Нет игроков'), style: const TextStyle(fontSize: 32, color: Colors.black)),
                            style: const TextStyle(fontSize: 32, color: Colors.black), // текст черный
                            iconSize: 48,
                            itemHeight: 80,
                          )
                        : Text('Нет доступных игроков', style: const TextStyle(fontSize: 24, color: Colors.red)),
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
            if (activePlayers.length < 2)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Добавьте минимум двух игроков!', style: TextStyle(color: Colors.red)),
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
  final PlayerRepository repository = PlayerRepository();
  List<Player> allPlayers = [];

  @override
  void initState() {
    super.initState();
    _loadPlayers();
  }

  Future<void> _loadPlayers() async {
    allPlayers = await repository.loadAllPlayers();
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
            onPressed: () async {
              if (newName.trim().isNotEmpty && !allPlayers.any((p) => p.name == newName)) {
                await repository.addPlayer(newName);
                await _loadPlayers();
              }
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
      body: allPlayers.isEmpty
          ? const Center(child: Text('Нет игроков'))
          : ListView.builder(
              itemCount: allPlayers.length,
              itemBuilder: (context, index) {
                final player = allPlayers[index];
                return CheckboxListTile(
                  title: Text(player.name),
                  value: player.isActive,
                  onChanged: (val) async {
                    await repository.setPlayerActive(player.name, val ?? true);
                    await _loadPlayers();
                  },
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
