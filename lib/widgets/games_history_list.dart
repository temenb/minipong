import 'package:flutter/material.dart';
import 'package:minipong/game_state.dart';

class GamesHistoryList extends StatefulWidget {
  final GameState gameState;
  const GamesHistoryList({super.key, required this.gameState});

  @override
  State<GamesHistoryList> createState() => _GamesHistoryListState();
}

class _GamesHistoryListState extends State<GamesHistoryList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant GamesHistoryList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Скроллим наверх при появлении новой игры
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final games = widget.gameState.sessionGames.toList().reversed.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('История игр', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                final gameNumber = index + 1; // Исправлено: теперь "Игра 1" — самая первая, "Игра N" — самая последняя
                final winnerName = widget.gameState.playerRepository.getPlayerById(game.winner)?.name ?? game.winner;
                final loserName = widget.gameState.playerRepository.getPlayerById(game.loser)?.name ?? game.loser;
                int player0Goals = game.scoreLog.where((e) => e.player == 0).length;
                int player1Goals = game.scoreLog.where((e) => e.player == 1).length;
                final player0Name = widget.gameState.playerRepository.getPlayerById(widget.gameState.playerIds[0])?.name ?? 'Игрок 1';
                final player1Name = widget.gameState.playerRepository.getPlayerById(widget.gameState.playerIds.length > 1 ? widget.gameState.playerIds[1] : '')?.name ?? 'Игрок 2';
                return ListTile(
                  title: Text('Игра $gameNumber'),
                  subtitle: Text(
                    'Победитель: $winnerName\n'
                    '$player0Name: $player0Goals\n'
                    '$player1Name: $player1Goals'
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
