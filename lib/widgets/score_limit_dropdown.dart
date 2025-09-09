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
      items: gameState.scoreOptions.map((score) {
        return DropdownMenuItem<int>(
          value: score,
          child: Text('$score'),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          gameState.selectedScore = value;
          if (onChanged != null) onChanged!();
        }
      },
    );
  }
}
