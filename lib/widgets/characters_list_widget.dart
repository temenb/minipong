import 'package:flutter/material.dart';
import 'package:minipong/managers/game_manager.dart';
import 'package:minipong/entity/character.dart';
import 'package:minipong/repositories/character_repository.dart';
import 'dart:math';
import 'package:minipong/widgets/character_list_item.dart';

class CharactersListWidget extends StatelessWidget {
  final GameManager gameManager;
  const CharactersListWidget({Key? key, required this.gameManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characters = gameManager.currentGame?.characters ?? [];
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            final randomNames = [
              'Артём', 'Виктор', 'Сергей', 'Алексей', 'Дмитрий',
              'Иван', 'Максим', 'Павел', 'Егор', 'Андрей',
              'Олег', 'Владимир', 'Игорь', 'Роман', 'Михаил',
              'Глеб', 'Антон', 'Кирилл', 'Виталий', 'Степан'
            ];
            final rand = Random();
            final name = randomNames[rand.nextInt(randomNames.length)];
            CharacterRepository.instance.addCharacter(Character(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: name,
            ));
          },
          child: const Text('Добавить игрока'),
        ),
        Expanded(
          child: characters.isEmpty
              ? const Center(child: Text('Нет игроков'))
              : ListView.builder(
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    final character = characters[index];
                    return CharacterListItem(character: character);
                  },
                ),
        ),
      ],
    );
  }
}
