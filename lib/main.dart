import 'package:flutter/material.dart';
import 'package:minipong/entity/char.dart';
import 'package:minipong/repositories/chars_repository.dart';
import 'package:minipong/managers/game_manager.dart';
import 'package:minipong/widgets/players_list_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GameManager gameManager = GameManager();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    print('MyApp.initState: старт инициализации GameManager');
    gameManager.init().then((_) {
      print('MyApp.initState: инициализация завершена');
      setState(() {
        _initialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return MaterialApp(
      home: PlayersScreen(gameManager: gameManager),
    );
  }
}

class PlayersScreen extends StatefulWidget {
  final GameManager gameManager;
  const PlayersScreen({super.key, required this.gameManager});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  GameManager get gameManager => widget.gameManager;

  Future<void> _addPlayer() async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить игрока'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Имя игрока'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (name != null && name.isNotEmpty) {
      final newChar = Char(id: DateTime.now().millisecondsSinceEpoch.toString(), name: name);
      gameManager.addPlayer(newChar);
      setState(() {});
    }
  }

  void _play() {
    final activePlayers = gameManager.chars.where((c) => gameManager.isPlayerActive(c.id)).toList();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Играть'),
        content: Text('Активных игроков: ${activePlayers.length}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final players = gameManager.chars;
    final activePlayersCount = players.where((c) => gameManager.isPlayerActive(c.id)).length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список игроков'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Добавить игрока',
            onPressed: _addPlayer,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PlayersListWidget(
              players: players,
              gameManager: gameManager,
              onChanged: () => setState(() {}),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: activePlayersCount >= 2 ? _play : null,
                child: const Text('Играть'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
