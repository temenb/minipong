import 'package:flutter/material.dart';
import 'package:minipong/game_state.dart';

class GamesHistoryList extends StatelessWidget {
  final GameState gameState;
  const GamesHistoryList({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('История игр', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: gameState.savedGames.length,
            itemBuilder: (context, index) {
              final game = gameState.savedGames[index];
              return ListTile(
                title: Text('Игра ${index + 1}'),
                subtitle: Text('Голов: ${game.length}'),
              );
            },
          ),
        ),
      ],
    );
  }
}

