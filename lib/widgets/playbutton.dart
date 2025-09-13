import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minipong/managers/game_manager.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);

  void _onPressed(BuildContext context) {
    Navigator.pushNamed(context, '/play');
  }

  @override
  Widget build(BuildContext context) {
    final gameManager = Provider.of<GameManager>(context);
    final canPlay = (gameManager.currentGame?.characterIds.length ?? 0) >= 2;

    return ElevatedButton(
      onPressed: canPlay ? () => _onPressed(context) : null,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(96), // высота в 2 раза больше стандартной (48)
      ),
      child: const Text('Играть', style: TextStyle(fontSize: 20)),
    );
  }
}
