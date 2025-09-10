import 'package:flutter/material.dart';
import '../entity/char.dart';
import '../game/game_state_manager.dart';

class PlayersListWidget extends StatelessWidget {
  final List<Char> players;
  final GameStateManager gameStateManager;
  final VoidCallback onChanged;

  const PlayersListWidget({
    super.key,
    required this.players,
    required this.gameStateManager,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return ListTile(
          title: Text(player.name),
          leading: Checkbox(
            value: gameStateManager.isPlayerActive(player.id),
            onChanged: (value) {
              gameStateManager.setPlayerActive(player.id, value ?? false);
              onChanged();
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Удалить игрока',
            onPressed: () async {
              gameStateManager.removePlayer(player.id);
              onChanged();
            },
          ),
        );
      },
    );
  }
}

