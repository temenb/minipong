import 'package:flutter/material.dart';
import 'package:minipong/entity/character.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;
  const CharacterListItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(character.name),
      // Можно добавить больше информации, если потребуется
    );
  }
}

