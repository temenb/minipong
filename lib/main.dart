import 'package:flutter/material.dart';
import 'entity/char.dart';
import 'repositories/chars_repository.dart';
import 'game/game_state_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PlayersScreen(),
    );
  }
}

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  final GameStateManager gameStateManager = GameStateManager();

  @override
  void initState() {
    super.initState();
    gameStateManager.init().then((_) {
      setState(() {});
    });
  }

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
      gameStateManager.addPlayer(newChar);
      setState(() {});
    }
  }

  void _play() {
    final activePlayers = gameStateManager.chars.where((c) => gameStateManager.isPlayerActive(c.id)).toList();
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
    final players = gameStateManager.chars;
    final activePlayersCount = players.where((c) => gameStateManager.isPlayerActive(c.id)).length;
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
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return ListTile(
                  title: Text(player.name),
                  leading: Checkbox(
                    value: gameStateManager.isPlayerActive(player.id),
                    onChanged: (value) {
                      gameStateManager.setPlayerActive(player.id, value ?? false);
                      setState(() {});
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: 'Удалить игрока',
                    onPressed: () async {
                      gameStateManager.removePlayer(player.id);
                      setState(() {});
                    },
                  ),
                );
              },
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
