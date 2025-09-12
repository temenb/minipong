import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minipong/managers/game_manager.dart';
import 'package:minipong/widgets/my_app.dart';
import 'package:minipong/services/storage_service.dart';
import 'package:minipong/repositories/character_repository.dart';
import 'package:minipong/managers/character_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final characterManager = CharacterManager();
  final gameManager = GameManager(characterManager);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: characterManager),
        ChangeNotifierProvider.value(value: gameManager),
      ],
      child: const MyApp(),
    ),
  );
}
