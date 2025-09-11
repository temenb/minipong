import 'package:flutter/material.dart';
import 'package:minipong/managers/game_manager.dart';
import 'package:minipong/widgets/characters_list_widget.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GameManager _gameManager;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _gameManager = GameManager();
    _gameManager.init().then((_) {
      setState(() {
        _initialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Список игроков')),
        body: _initialized
            ? CharactersListWidget(gameManager: _gameManager)
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

