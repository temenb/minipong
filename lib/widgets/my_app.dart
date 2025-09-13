import 'package:flutter/material.dart';
import 'package:minipong/widgets/characters_list.dart';
import 'package:minipong/widgets/playbutton.dart';
import 'package:minipong/widgets/play_screen.dart';
import 'package:minipong/managers/game_manager.dart';
import 'package:minipong/managers/character_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainAppScreen();
  }
}

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final characterManager = CharacterManager();
    final gameManager = GameManager(characterManager);
    return MaterialApp(
      // theme: определяет стили приложения
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: главный экран приложения
      home: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 32), // отступ сверху
            const PlayButton(),
            const SizedBox(height: 8), // уменьшенный отступ
            Expanded(
              child: Center(
                child: CharactersList(),
              ),
            ),
          ],
        ),
      ),
      routes: {
        '/play': (context) => PlayScreen(gameManager: gameManager),
      },
    );
  }
}
