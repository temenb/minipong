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
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final games = widget.gameState.sessionGames;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('История игр', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            reverse: true,
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              final gameNumber = games.length - index;
              return ListTile(
                title: Text('Игра $gameNumber'),
                subtitle: Text('Голов: ${game.length}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
