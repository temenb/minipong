import 'package:flutter/material.dart';

class GameHistoryEntry {
  final String player1;
  final String player2;
  final int score1;
  final int score2;
  final String winner;
  final DateTime time;

  GameHistoryEntry({
    required this.player1,
    required this.player2,
    required this.score1,
    required this.score2,
    required this.winner,
    required this.time,
  });
}

class GameHistoryWidget extends StatelessWidget {
  const GameHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Тестовые данные
    final List<GameHistoryEntry> history = [
      GameHistoryEntry(
        player1: 'Аня',
        player2: 'Борис',
        score1: 5,
        score2: 3,
        winner: 'Аня',
        time: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      GameHistoryEntry(
        player1: 'Вика',
        player2: 'Дима',
        score1: 2,
        score2: 5,
        winner: 'Дима',
        time: DateTime.now().subtract(const Duration(hours: 1, minutes: 5)),
      ),
    ];

    return Container(
      width: 260,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('История игр', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          ...history.map((entry) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${entry.player1} vs ${entry.player2}', style: const TextStyle(fontSize: 16), softWrap: true),
                Text('Счет: ${entry.score1} - ${entry.score2}', style: const TextStyle(fontSize: 14), softWrap: true),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.emoji_events, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(entry.winner, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14), softWrap: true),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  _formatTime(entry.time),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  softWrap: true,
                ),
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
