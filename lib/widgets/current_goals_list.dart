import 'package:flutter/material.dart';
import 'package:minipong/game_state.dart';

class CurrentGoalsList extends StatelessWidget {
  final GameState gameState;
  const CurrentGoalsList({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Голы в текущей партии', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: gameState.scoreLog.length,
            itemBuilder: (context, index) {
              final entry = gameState.scoreLog[index];
              return ListTile(
                title: Text('Игрок ${entry.player}: +${entry.delta}'),
                subtitle: Text('${entry.timestamp.hour}:${entry.timestamp.minute}:${entry.timestamp.second}'),
              );
            },
          ),
        ),
      ],
    );
  }
}

