import 'package:flutter/material.dart';
import 'package:minipong/player_repository.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  final PlayerRepository _repository = PlayerRepository.instance;
  List<Player> _players = [];
  final TextEditingController _controller = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPlayers();
  }

  Future<void> _loadPlayers() async {
    final players = await _repository.loadAllPlayers();
    setState(() {
      _players = players;
      _loading = false;
    });
  }

  Future<void> _addPlayer(String name) async {
    if (name.trim().isEmpty) return;
    await _repository.addPlayer(name.trim());
    _controller.clear();
    await _loadPlayers();
  }

  Future<void> _removePlayer(String name) async {
    _players.removeWhere((p) => p.name == name);
    await _repository.saveAllPlayers(_players);
    setState(() {});
  }

  void _toggleActive(Player player) {
    setState(() {
      player.isActive = !player.isActive;
    });
    // Активность не сохраняем в хранилище
  }

  Future<void> _movePlayerUp(int index) async {
    int? targetIndex;
    for (int i = index - 1; i >= 0; i--) {
      if (_players[i].isActive) {
        targetIndex = i;
        break;
      }
    }
    if (targetIndex != null) {
      setState(() {
        final temp = _players[targetIndex!];
        _players[targetIndex!] = _players[index];
        _players[index] = temp;
      });
      await _repository.saveAllPlayers(_players);
    }
  }

  Future<void> _movePlayerDown(int index) async {
    int? targetIndex;
    for (int i = index + 1; i < _players.length; i++) {
      if (_players[i].isActive) {
        targetIndex = i;
        break;
      }
    }
    if (targetIndex != null) {
      setState(() {
        final temp = _players[targetIndex!];
        _players[targetIndex!] = _players[index];
        _players[index] = temp;
      });
      await _repository.saveAllPlayers(_players);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список игроков')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            labelText: 'Имя игрока',
                          ),
                          onSubmitted: _addPlayer,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _addPlayer(_controller.text),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                      itemCount: _players.length,
                      itemBuilder: (context, index) {
                        final player = _players[index];
                        return ListTile(
                          leading: Checkbox(
                            value: player.isActive,
                            onChanged: (_) => _toggleActive(player),
                          ),
                          title: Text(player.name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_upward),
                                tooltip: 'Вверх',
                                onPressed: player.isActive && _hasActiveAbove(index) ? () => _movePlayerUp(index) : null,
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_downward),
                                tooltip: 'Вниз',
                                onPressed: player.isActive && _hasActiveBelow(index) ? () => _movePlayerDown(index) : null,
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _removePlayer(player.name),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  bool _hasActiveAbove(int index) {
    for (int i = index - 1; i >= 0; i--) {
      if (_players[i].isActive) return true;
    }
    return false;
  }

  bool _hasActiveBelow(int index) {
    for (int i = index + 1; i < _players.length; i++) {
      if (_players[i].isActive) return true;
    }
    return false;
  }
}
