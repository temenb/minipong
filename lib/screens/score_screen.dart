import 'package:flutter/material.dart';
import '../widgets/score_limit_dropdown.dart';
import '../game_state.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final GameState gameState = GameState.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Счет матча')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Игра до:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            ScoreLimitDropdown(
              gameState: gameState,
              onChanged: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
