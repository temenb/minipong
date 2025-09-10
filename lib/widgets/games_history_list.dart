import 'package:flutter/material.dart';
import 'package:minipong/game_state.dart';
import 'package:minipong/repositories/player_repository.dart';

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
                final gameNumber = index + 1;
                final winnerPlayer = game.players.firstWhere(
                  (p) => p.id == game.winner,
                  orElse: () => game.players.isNotEmpty ? game.players[0] : Player('', id: '', isActive: false)
                );
                final loserPlayer = game.players.firstWhere(
                  (p) => p.id == game.loser,
                  orElse: () => game.players.length > 1 ? game.players[1] : Player('', id: '', isActive: false)
                );
                final winnerName = winnerPlayer.name.isNotEmpty ? winnerPlayer.name : game.winner;
                final loserName = loserPlayer.name.isNotEmpty ? loserPlayer.name : game.loser;
                final player0Name = game.players.isNotEmpty ? game.players[0].name : 'Игрок 1';
                final player1Name = game.players.length > 1 ? game.players[1].name : 'Игрок 2';
                int player0Goals = game.scoreLog.where((e) => e.player == 0).length;
                int player1Goals = game.scoreLog.where((e) => e.player == 1).length;
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
