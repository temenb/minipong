import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minipong/managers/character_manager.dart';
import 'package:minipong/widgets/character_list_item.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterManager>(
      builder: (context, manager, child) {
        final characters = manager.characters;
        if (characters.isEmpty) {
          return const Center(child: Text('Нет персонажей'));
        }
        return ListView.builder(
          itemCount: characters.length,
          itemBuilder: (context, index) {
            final character = characters[index];
            return CharacterListItem(character: character);
          },
        );
      },
    );
  }
}
