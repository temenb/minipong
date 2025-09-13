import 'package:flutter/material.dart';
import 'package:minipong/managers/game_manager.dart';
import 'package:minipong/widgets/score_counter.dart';
import 'package:minipong/widgets/game_history_widget.dart';
import 'package:minipong/widgets/goal_history_widget.dart';

class PlayScreen extends StatelessWidget {
  final GameManager gameManager;
  const PlayScreen({Key? key, required this.gameManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = gameManager.currentGame;
    return Scaffold(
      appBar: AppBar(title: const Text('Игра')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (game != null)
              ScoreCounter(game: game),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(width: 140, child: GameHistoryWidget()),
                SizedBox(width: 32),
                SizedBox(width: 140, child: GoalHistoryWidget()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
