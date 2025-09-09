import 'package:flutter/material.dart';
import '../game_state.dart';

class ScoreLimitDropdown extends StatelessWidget {
  final GameState gameState;
  final VoidCallback? onChanged;

  const ScoreLimitDropdown({
    super.key,
    required this.gameState,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: gameState.selectedScore,
      items: List.generate(gameState.scoreOptions.length, (index) {
        return DropdownMenuItem<int>(
          value: index,
          child: Text('${gameState.scoreOptions[index]}'),
        );
      }),
      onChanged: (index) {
        if (index != null) {
          gameState.selectedScore = index;
          if (onChanged != null) onChanged!();
        }
      },
    );
  }
}
