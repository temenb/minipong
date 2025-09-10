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
  final FocusNode _focusNode = FocusNode();

  void _handleKeyEvent(KeyEvent event) async {
    if (event is KeyDownEvent) {
      final key = event.logicalKey;
      print('[DEBUG] Key event: $key, ctrl: ￿{HardwareKeyboard.instance.isControlPressed}');
      // Ctrl + Space для нулевого игрока
      if (key == LogicalKeyboardKey.space ||
          (HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.controlLeft) ||
           HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.controlRight))) {
        print('[DEBUG] Ctrlor Space detected');
        await gameState.addGoalToPlayer(0);
        setState(() {});
      }
      // Enter для первого игрока
      if (key == LogicalKeyboardKey.enter) {
        print('[DEBUG] Enter detected');
        await gameState.addGoalToPlayer(1);
        setState(() {});
      }
    }
  }

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
    return KeyboardListener(
      autofocus: true,
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
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
                  selectedPlayerIndex: gameState.activePlayerNames.indexOf(gameState.players[gameState.firPlayer == 0 ? 0 : 1]),
                  onPlayerChanged: (index) {
                    setState(() {
                      gameState.setSelectedPlayer1(gameState.activePlayerNames[index]);
                    });
                  },
                  score: gameState.firPlayer == 0 ? gameState.player1Score : gameState.player2Score,
                  onAddScore: () async {
                    await gameState.addGoalToPlayer(gameState.firPlayer);
                    setState(() {});
                  },
                  isGreen: gameState.serverPlayer == gameState.firPlayer,
                  isPink: gameState.receiverPlayer == gameState.firPlayer,
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
                  selectedPlayerIndex: gameState.activePlayerNames.indexOf(gameState.players[gameState.firPlayer == 0 ? 1 : 0]),
                  onPlayerChanged: (index) {
                    setState(() {

                      print('====================================================================================================================');
                      print(gameState.activePlayerNames[index]);
                      gameState.setSelectedPlayer2(gameState.activePlayerNames[index]);
                    });
                  },
                  score: gameState.secPlayer == 0 ? gameState.player1Score : gameState.player2Score,
                  onAddScore: () async {
                    await gameState.addGoalToPlayer(gameState.secPlayer);
                    setState(() {});
                  },
                  isGreen: gameState.serverPlayer == gameState.secPlayer,
                  isPink: gameState.receiverPlayer == gameState.secPlayer,
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Сохранить игру'),
                onPressed: gameState.saveGameAndSwitchPlayers,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
