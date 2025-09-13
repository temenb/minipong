import 'package:flutter/material.dart';
import 'package:minipong/entity/character.dart';

class UserScore extends StatelessWidget {
  final List<Character> characters;
  final Character? selected;
  final int score;
  final ValueChanged<Character?> onPlayerChanged;
  final VoidCallback onAdd;
  const UserScore({
    Key? key,
    required this.characters,
    required this.selected,
    required this.score,
    required this.onPlayerChanged,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start, // элементы прижаты к верху
      children: [
        DropdownButton<Character>(
          value: selected,
          items: characters.map((c) => DropdownMenuItem<Character>(
            value: c,
            child: Text(c.name),
          )).toList(),
          onChanged: onPlayerChanged,
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Text(
            score.toString(),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: onAdd,
        ),
      ],
    );
  }
}
