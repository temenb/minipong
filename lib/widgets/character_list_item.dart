import 'package:flutter/material.dart';
import 'package:minipong/entity/character.dart';
import 'package:minipong/managers/game_manager.dart';
import 'package:provider/provider.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;

  const CharacterListItem({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Используем Selector для отслеживания изменений только по characterIds
    return Selector<GameManager, bool>(
      selector: (context, gm) {
        final currentGame = gm.currentGame;
        return currentGame?.characterIds.contains(character.id) ?? false;
      },
      builder: (context, isChecked, child) {
        return ListTile(
          title: Text(character.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          leading: Checkbox(
            value: isChecked,
            onChanged: (checked) {
              final gameManager = Provider.of<GameManager>(context, listen: false);
              if (checked == true) {
                gameManager.addToActivePlayers(character.id);
              } else {
                gameManager.removeFromActivePlayers(character.id);
              }
            },
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
      },
    );
  }
}
