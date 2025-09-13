import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minipong/managers/character_manager.dart';
import 'package:minipong/widgets/character_list_item.dart';

class CharactersList extends StatefulWidget {
  const CharactersList({Key? key}) : super(key: key);

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addCharacter(CharacterManager manager) {
    final name = _controller.text.trim();
    if (name.isNotEmpty) {
      manager.addCharacter(name);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterManager>(
      builder: (context, manager, child) {
        final characters = manager.characters;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Имя персонажа',
                      ),
                      onSubmitted: (_) => _addCharacter(manager),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Добавить персонажа',
                    onPressed: () => _addCharacter(manager),
                  ),
                ],
              ),
            ),
            Expanded(
              child: characters.isEmpty
                  ? const Center(child: Text('Нет персонажей'))
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
      },
    );
  }
}
