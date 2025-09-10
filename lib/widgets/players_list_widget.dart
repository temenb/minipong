import 'package:flutter/material.dart';
import 'package:minipong/entity/char.dart';
import 'package:minipong/managers/game_manager.dart';

class PlayersListWidget extends StatelessWidget {
  final List<Char> players;
  final GameManager gameManager;
  final VoidCallback onChanged;

  const PlayersListWidget({
    super.key,
    required this.players,
    required this.gameManager,
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
            value: gameManager.isPlayerActive(player.id),
            onChanged: (value) {
              gameManager.setPlayerActive(player.id, value ?? false);
              onChanged();
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Удалить игрока',
            onPressed: () async {
              gameManager.removePlayer(player.id);
              onChanged();
            },
          ),
        );
      },
    );
  }
}
