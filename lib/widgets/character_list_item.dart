import 'package:flutter/material.dart';
import 'package:minipong/entity/character.dart';
import 'package:minipong/managers/game_manager.dart';
import 'package:provider/provider.dart';

class CharacterListItem extends StatefulWidget {
  final Character character;

  const CharacterListItem({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  State<CharacterListItem> createState() => _CharacterListItemState();
}

class _CharacterListItemState extends State<CharacterListItem> {
  bool _editing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.character.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startEdit() {
    setState(() {
      _editing = true;
    });
  }

  void _finishEdit() {
    setState(() {
      _editing = false;
      widget.character.name = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Используем Selector для отслеживания изменений только по characterIds
    return Selector<GameManager, bool>(
      selector: (context, gm) {
        final currentGame = gm.currentGame;
        return currentGame?.characterIds.contains(widget.character.id) ?? false;
      },
      builder: (context, isChecked, child) {
        return ListTile(
          title: _editing
              ? TextField(
                  controller: _controller,
                  autofocus: true,
                  onSubmitted: (_) => _finishEdit(),
                  onEditingComplete: _finishEdit,
                )
              : GestureDetector(
                  onTap: _startEdit,
                  child: Text(widget.character.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
          leading: Checkbox(
            value: isChecked,
            onChanged: (checked) {
              final gameManager = Provider.of<GameManager>(context, listen: false);
              if (checked == true) {
                gameManager.addToActivePlayers(widget.character.id);
              } else {
                gameManager.removeFromActivePlayers(widget.character.id);
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
