import 'package:flutter/material.dart';

class GoalHistoryEntry {
  final String player;
  final DateTime time;

  GoalHistoryEntry({required this.player, required this.time});
}

class GoalHistoryWidget extends StatelessWidget {
  const GoalHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Тестовые данные
    final List<GoalHistoryEntry> history = [
      GoalHistoryEntry(player: 'Аня', time: DateTime.now().subtract(const Duration(minutes: 2))),
      GoalHistoryEntry(player: 'Борис', time: DateTime.now().subtract(const Duration(minutes: 5))),
      GoalHistoryEntry(player: 'Дима', time: DateTime.now().subtract(const Duration(minutes: 12))),
    ];
    return Container(
      width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('История голов', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          ...history.map((entry) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.player, style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 2),
                Text(_formatTime(entry.time), style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

String _formatTime(DateTime time) {
  final now = DateTime.now();
  final diff = now.difference(time);
  if (diff.inMinutes < 60) {
    return '${diff.inMinutes} мин назад';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} ч назад';
  } else {
    return '${time.day}.${time.month}.${time.year}';
  }
}
