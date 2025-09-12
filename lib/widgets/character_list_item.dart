import 'package:flutter/material.dart';
import 'package:minipong/entity/character.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;

  const CharacterListItem({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(character.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      leading: Checkbox(
        value: true,
        onChanged: (_) {},
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_upward),
            tooltip: 'Вверх',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.arrow_downward),
            tooltip: 'Вниз',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            tooltip: 'Удалить',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
