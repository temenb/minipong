import 'package:flutter/material.dart';
import 'package:minipong/entity/character.dart';
import 'package:minipong/managers/game_manager.dart';
import 'package:minipong/managers/character_manager.dart';
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
  final FocusNode _focusNode = FocusNode();

  late CharacterManager _characterManager;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.character.name);
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _characterManager = Provider.of<CharacterManager>(context);
    _characterManager.addListener(_onCharacterManagerChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _characterManager.removeListener(_onCharacterManagerChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onCharacterManagerChanged() {
    // Обновляем текстовое поле, ес��и имя персонажа изменилось извне
    if (!_editing) {
      _controller.text = widget.character.name;
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _startEdit() {
    setState(() {
      _editing = true;
    });
    Future.delayed(Duration(milliseconds: 10), () {
      _focusNode.requestFocus();
    });
  }

  void _finishEdit() {
    setState(() {
      _editing = false;
    });
    _characterManager.renameCharacter(widget.character.id, _controller.text);
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus && _editing) {
      _finishEdit();
    }
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
                  focusNode: _focusNode,
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
              if (isChecked) ...[
                IconButton(
                  icon: const Icon(Icons.arrow_upward),
                  tooltip: 'Вверх',
                  onPressed: () {
                    final gameManager = Provider.of<GameManager>(context, listen: false);
                    _characterManager.moveCharacterUp(widget.character.id, gameManager);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_downward),
                  tooltip: 'Вниз',
                  onPressed: () {
                    final gameManager = Provider.of<GameManager>(context, listen: false);
                    _characterManager.moveCharacterDown(widget.character.id, gameManager);
                  },
                ),
              ],
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Удалить',
                onPressed: () {
                  _characterManager.removeCharacter(widget.character.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
