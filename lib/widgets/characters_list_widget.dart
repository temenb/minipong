import 'package:flutter/material.dart';
import 'package:minipong/managers/game_manager.dart';
import 'package:minipong/widgets/character_list_item.dart';
import 'package:minipong/entity/character.dart';

class CharactersListWidget extends StatelessWidget {
  final GameManager gameManager;
  final void Function(Character)? onRemove;

  const CharactersListWidget({Key? key, required this.gameManager, this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characters = gameManager.characters;
    if (characters.isEmpty) {
      return const Center(child: Text('Нет игроков'));
    }
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        final isActive = gameManager.activePlayerIds.contains(character.id);
        return CharacterListItem(
          character: character,
          isActive: isActive,
          onActiveChanged: (value) {
            if (value) {
              gameManager.activePlayerIds.add(character.id);
            } else {
              gameManager.activePlayerIds.remove(character.id);
            }
            gameManager.notifyListeners();
          },
          onRemove: (char) {
            gameManager.characters.removeWhere((c) => c.id == char.id);
        );
      },
    );
  }
}
