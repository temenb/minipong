import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minipong/managers/character_manager.dart';

class CharactersTextList extends StatefulWidget {
  final String title;
  const CharactersTextList({super.key, this.title = 'Список персонажей'});

  @override
  State<CharactersTextList> createState() => _CharactersTextListState();
}

class _CharactersTextListState extends State<CharactersTextList> {
  void _addCharacter() async {
    final nameController = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить персонажа'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'Имя персонажа'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(nameController.text);
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
    if (result != null && result.trim().isNotEmpty) {
      final characterManager = Provider.of<CharacterManager>(context, listen: false);
      characterManager.addCharacter(result.trim());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final characterManager = Provider.of<CharacterManager>(context);
    final characters = characterManager.characters;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _addCharacter,
          child: const Text('Добавить персонажа'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            final characterManager = Provider.of<CharacterManager>(context, listen: false);
            await characterManager.getAllFromStorage();
            setState(() {});
          },
          child: const Text('Обновить'),
        ),
        const SizedBox(height: 16),
        if (characters.isEmpty)
          const Text('Нет персонажей')
        else
          for (final c in characters)
            Text('id: ${c.id}'),
      ],
    );
  }
}
