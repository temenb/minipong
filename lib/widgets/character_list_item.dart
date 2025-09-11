import 'package:flutter/material.dart';
import 'package:minipong/entity/character.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;
  final bool isActive;
  final void Function(bool)? onActiveChanged;
  final void Function(Character)? onRemove;

  const CharacterListItem({
    Key? key,
    required this.character,
    required this.isActive,
    this.onActiveChanged,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isActive,
        onChanged: onActiveChanged != null
            ? (value) => onActiveChanged!(value ?? false)
            : null,
      ),
      title: Text(character.name),
      trailing: onRemove != null
          ? IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onRemove!(character),
            )
          : null,
    );
  }
}
