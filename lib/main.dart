import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minipong/managers/game_manager.dart';
import 'package:minipong/widgets/my_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameManager(),
      child: const MyApp(),
    ),
  );
}
