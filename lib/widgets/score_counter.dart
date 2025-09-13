import 'package:flutter/material.dart';

class ScoreCounter extends StatefulWidget {
  const ScoreCounter({Key? key}) : super(key: key);

  @override
  State<ScoreCounter> createState() => _ScoreCounterState();
}

class _ScoreCounterState extends State<ScoreCounter> {
  int score1 = 0;
  int score2 = 0;
  String? selected1;
  String? selected2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Первая колонка: первый дропдаун, счет, кнопка
        Column(
          children: [
            DropdownButton<String>(
              value: selected1,
              items: const [],
              onChanged: (val) => setState(() => selected1 = val),
            ),
            Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Text('$score1', style: const TextStyle(fontSize: 24)),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => setState(() => score1++),
            ),
          ],
        ),
        // Центральная колонка: стрелочки, замок, стрелочки
        Column(
          children: [
            const SizedBox(height: 8),
            const Icon(Icons.swap_horiz, size: 28, color: Colors.grey), // верхние стрелочки
            const SizedBox(height: 8),
            const Icon(Icons.lock, size: 28, color: Colors.grey), // замок
            const SizedBox(height: 8),
            const Icon(Icons.swap_horiz, size: 28, color: Colors.grey), // нижние стрелочки
            const SizedBox(height: 8),
          ],
        ),
        // Вторая колонка: второй дропдаун, счет, кнопка
        Column(
          children: [
            DropdownButton<String>(
              value: selected2,
              items: const [],
              onChanged: (val) => setState(() => selected2 = val),
            ),
            Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: Text('$score2', style: const TextStyle(fontSize: 24)),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => setState(() => score2++),
            ),
          ],
        ),
      ],
    );
  }
}
