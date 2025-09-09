import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void _saveGameAndSwitchPlayers() async {
    await gameState.saveCurrentGame();
    // Определяем победителя и проигравшего
    int p1Score = gameState.player1Score;
    int p2Score = gameState.player2Score;
    int winnerIdx = p1Score > p2Score ? 0 : 1;
    int loserIdx = p1Score > p2Score ? 1 : 0;
    // Победитель
    String winner = gameState.players[winnerIdx];
    // Проигравший
    String loser = gameState.players[loserIdx];
    // Победитель становится первым
    gameState.players[0] = winner;
    // Проигравший становится вторым или следующим
    if (gameState.players.length > 2) {
      // Найти следующего игрока (если есть)
      int nextIdx = 2;
      String nextPlayer = gameState.players[nextIdx];
      gameState.players[1] = nextPlayer;
      // Проигравший уходит в конец
      gameState.players.removeAt(loserIdx);
      gameState.players.add(loser);
    } else {
      gameState.players[1] = loser;
    }
    setState(() {});
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

    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent) {
          final key = event.logicalKey;
          // Пробел или Ctrl — гол игроку 0
          if (key == LogicalKeyboardKey.space || event.isControlPressed) {
            gameState.addGoalToPlayer(1);
            setState(() {});
          }
          // Enter или NumPad Enter — гол игроку 1
          if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.numpadEnter) {
            gameState.addGoalToPlayer(2);
            setState(() {});
          }
        }
      },
      child: Scaffold(
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
                // Виджет для firPlayer
                PlayerScoreWidget(
                  playerNames: gameState.activePlayerNames,
                  selectedPlayerIndex: gameState.firPlayer,
                  onPlayerChanged: (index) {
                    setState(() {
                      gameState.players[gameState.firPlayer] = gameState.activePlayerNames[index];
                    });
                  },
                  score: gameState.firPlayer == 0 ? gameState.player1Score : gameState.player2Score,
                  onAddScore: () {
                    gameState.addGoalToPlayer(gameState.firPlayer + 1);
                    setState(() {});
                  },
                  isGreen: gameState.greenPlayer == gameState.firPlayer,
                  isPink: gameState.pinkPlayer == gameState.firPlayer,
                  enabled: !gameState.isGameFinished(),
                  dropdownEnabled: gameState.totalScore == 0,
                ),
                // Кнопка смены игроков и замок
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: IconButton(
                        icon: const Icon(Icons.swap_horiz, size: 32),
                        tooltip: 'Поменять местами игроков',
                        onPressed: gameState.totalScore == 0
                            ? () {
                                setState(() {
                                  if (gameState.players.length > 1) {
                                    final tmp = gameState.players[0];
                                    gameState.players[0] = gameState.players[1];
                                    gameState.players[1] = tmp;
                                  }
                                });
                              }
                            : null,
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
                // Виджет для secPlayer
                PlayerScoreWidget(
                  playerNames: gameState.activePlayerNames,
                  selectedPlayerIndex: gameState.secPlayer,
                  onPlayerChanged: (index) {
                    setState(() {
                      gameState.players[gameState.secPlayer] = gameState.activePlayerNames[index];
                    });
                  },
                  score: gameState.secPlayer == 0 ? gameState.player1Score : gameState.player2Score,
                  onAddScore: () {
                    gameState.addGoalToPlayer(gameState.secPlayer + 1);
                    setState(() {});
                  },
                  isGreen: gameState.greenPlayer == gameState.secPlayer,
                  isPink: gameState.pinkPlayer == gameState.secPlayer,
                  enabled: !gameState.isGameFinished(),
                  dropdownEnabled: gameState.totalScore == 0,
                ),
              ],
            ),
            // ...счет игроков...
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CurrentGoalsList(
                      gameState: gameState,
                      onDelete: (index) {
                        setState(() {
                          gameState.deleteLogEntry(index);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: GamesHistoryList(gameState: gameState),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
