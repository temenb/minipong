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
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: selected1,
              items: const [],
              onChanged: (val) => setState(() => selected1 = val),
            ),
            Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Text('$score1', style: const TextStyle(fontSize: 32)),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => setState(() => score1++),
            ),
          ],
        ),
        // Центральная колонка: стрелочки, замок, стрелочки
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // убрано пустое место сверху
            const Icon(Icons.swap_horiz, size: 28, color: Colors.grey), // верхние стрелочки
            const SizedBox(height: 20),
            const Icon(Icons.lock, size: 32, color: Colors.grey), // замок
            const SizedBox(height: 32), // уменьшенный отступ для нижних стрелочек
            const Icon(Icons.swap_horiz, size: 28, color: Colors.grey), // нижние стрелочки
          ],
        ),
        // Вторая колонка: второй дропдаун, счет, кнопка
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: selected2,
              items: const [],
              onChanged: (val) => setState(() => selected2 = val),
            ),
            Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: Text('$score2', style: const TextStyle(fontSize: 32)),
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
