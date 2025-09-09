import 'package:flutter/material.dart';
import 'package:minipong/widgets/score_limit_dropdown.dart';

class PlayerScoreWidget extends StatelessWidget {
  final List<String> playerNames;
  final int selectedPlayerIndex;
  final ValueChanged<int> onPlayerChanged;
  final int score;
  final VoidCallback onAddScore;

  const PlayerScoreWidget({
    super.key,
    required this.playerNames,
    required this.selectedPlayerIndex,
    required this.onPlayerChanged,
    required this.score,
    required this.onAddScore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<int>(
          value: selectedPlayerIndex,
          items: List.generate(playerNames.length, (index) {
            return DropdownMenuItem<int>(
              value: index,
              child: Text(playerNames[index]),
            );
          }),
          onChanged: (index) {
            if (index != null) onPlayerChanged(index);
          },
        ),
        const SizedBox(height: 16),
        Container(
          width: 80,
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue, width: 2),
          ),
          child: Text(
            '$score',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onAddScore,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
