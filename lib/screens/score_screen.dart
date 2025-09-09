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
    if (gameState.activePlayerNames.length < 2) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Счет'),
        ),
        body: const Center(
          child: Text(
            'добавьте минимум двух игроков',
            style: TextStyle(fontSize: 24, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

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
                selectedPlayerIndex: (() {
                  final idx = gameState.activePlayerNames.indexOf(
                    gameState.players.isNotEmpty ? gameState.players[gameState.firPlayer] : ''
                  );
                  return idx >= 0 ? idx : null;
                })(),
                onPlayerChanged: (index) {
                  if (gameState.activePlayerNames.isNotEmpty) {
                    gameState.setSelectedPlayer1(gameState.activePlayerNames[index]);
                    setState(() {});
                  }
                },
                score: gameState.player1Score,
                onAddScore: () {
                  gameState.addGoalToPlayer(1);
                  setState(() {});
                },
                isGreen: gameState.greenPlayer == gameState.firPlayer,
                isPink: gameState.pinkPlayer == gameState.firPlayer,
              ),
              // Кнопка смены игроков и замок
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                      icon: const Icon(Icons.swap_horiz, size: 32),
                      tooltip: 'Поменять местами игроков',
                      onPressed: () {
                        setState(() {
                          if (gameState.players.length > 1) {
                            final tmp = gameState.players[0];
                            gameState.players[0] = gameState.players[1];
                            gameState.players[1] = tmp;
                          }
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(gameState.lock ? Icons.lock : Icons.lock_open),
                    tooltip: gameState.lock ? 'Замок закрыт' : 'Замок открыт',
                    onPressed: () {
                      setState(() {
                        gameState.lock = !gameState.lock;
                      });
                    },
                  ),
                ],
              ),
              PlayerScoreWidget(
                playerNames: gameState.activePlayerNames,
                selectedPlayerIndex: (() {
                  final idx = gameState.activePlayerNames.indexOf(
                    gameState.players.length > 1 ? gameState.players[gameState.secPlayer] : ''
                  );
                  return idx >= 0 ? idx : null;
                })(),
                onPlayerChanged: (index) {
                  if (gameState.activePlayerNames.length > 1) {
                    gameState.setSelectedPlayer2(gameState.activePlayerNames[index]);
                    setState(() {});
                  }
                },
                score: gameState.player2Score,
                onAddScore: () {
                  gameState.addGoalToPlayer(2);
                  setState(() {});
                },
                isGreen: gameState.greenPlayer == gameState.secPlayer,
                isPink: gameState.pinkPlayer == gameState.secPlayer,
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
