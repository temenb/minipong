import 'package:flutter/material.dart';
import 'package:minipong/game_state.dart';
import 'package:minipong/widgets/player_score_widget.dart';
import 'package:minipong/widgets/score_limit_dropdown.dart';
import 'package:minipong/widgets/current_goals_list.dart';
import 'package:minipong/widgets/games_history_list.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlayerScoreWidget(
                playerNames: gameState.activePlayerNames,
                selectedPlayerIndex: 0,
                onPlayerChanged: (index) {
                  if (gameState.activePlayerNames.isNotEmpty) {
                    gameState.setSelectedPlayer1(
                      gameState.activePlayerNames[index],
                    );
                    setState(() {});
                  }
                },
                score: gameState.player1Score,
                onAddScore: () {
                  gameState.addGoalToPlayer(1);
                  setState(() {});
                },
              ),
              const SizedBox(width: 32),
              PlayerScoreWidget(
                playerNames: gameState.activePlayerNames,
                selectedPlayerIndex: 1,
                onPlayerChanged: (index) {
                  if (gameState.activePlayerNames.length > 1) {
                    gameState.setSelectedPlayer2(
                      gameState.activePlayerNames[index],
                    );
                    setState(() {});
                  }
                },
                score: gameState.player2Score,
                onAddScore: () {
                  gameState.addGoalToPlayer(2);
                  setState(() {});
                },
              ),
            ],
          ),
          // ...счет игроков...
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CurrentGoalsList(gameState: gameState),
                ),
                Expanded(
                  child: GamesHistoryList(gameState: gameState),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
