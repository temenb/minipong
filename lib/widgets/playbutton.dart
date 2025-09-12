import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);

  void _onPressed() {
    // Логика начала игры
    print('Игра началась!');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(96), // высота в 2 раза больше стандартной (48)
      ),
      child: const Text('Играть', style: TextStyle(fontSize: 20)),
    );
  }
}
