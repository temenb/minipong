import 'package:flutter/material.dart';
import 'package:minipong/game_state.dart';

class CurrentGoalsList extends StatefulWidget {
  final GameState gameState;
  final ValueChanged<int>? onDelete;
  const CurrentGoalsList({super.key, required this.gameState, this.onDelete});

  @override
  State<CurrentGoalsList> createState() => _CurrentGoalsListState();
}

class _CurrentGoalsListState extends State<CurrentGoalsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant CurrentGoalsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Автопрокрутка наверх после добавления гола
    if (widget.gameState.scoreLog.length > oldWidget.gameState.scoreLog.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reversedLog = widget.gameState.scoreLog.reversed.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Голы в текущей партии', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: reversedLog.length,
              itemBuilder: (context, index) {
                final entry = reversedLog[index];
                return ListTile(
                  title: Text('Игрок ${entry.player}: +${entry.delta}'),
                  subtitle: Text('${entry.timestamp.hour}:${entry.timestamp.minute}:${entry.timestamp.second}'),
                  trailing: widget.onDelete != null
                      ? IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          tooltip: 'Удалить гол',
                          onPressed: () => widget.onDelete!(widget.gameState.scoreLog.length - 1 - index),
                        )
                      : null,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
