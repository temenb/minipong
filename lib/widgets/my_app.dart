import 'package:flutter/material.dart';
import 'package:minipong/widgets/characters_list.dart';

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
    return MaterialApp(
      // theme: определяет стили приложения
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: главный экран приложения
      home: const Scaffold(
        body: Center(
          child: CharactersList(),
        ),
      ),
    );
  }
}
