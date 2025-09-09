import 'package:flutter/material.dart';
import '../widgets/score_limit_dropdown.dart';
import '../game_state.dart';
import '../widgets/player_score_widget.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final GameState gameState = GameState.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Игра до: ', style: TextStyle(fontSize: 20)),
            ScoreLimitDropdown(
              gameState: gameState,
              onChanged: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlayerScoreWidget(
              playerNames: gameState.players,
              selectedPlayerIndex: 0,
              onPlayerChanged: (index) {
                gameState.setSelectedPlayer1(gameState.players[index]);
                setState(() {});
              },
              score: gameState.player1Score,
              onAddScore: () {
                gameState.addGoalToPlayer(1);
                setState(() {});
              },
            ),
            const SizedBox(width: 32),
            PlayerScoreWidget(
              playerNames: gameState.players,
              selectedPlayerIndex: 1,
              onPlayerChanged: (index) {
                gameState.setSelectedPlayer2(gameState.players[index]);
                setState(() {});
              },
              score: gameState.player2Score,
              onAddScore: () {
                gameState.addGoalToPlayer(2);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
