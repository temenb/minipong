import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Здесь можно заменить на реальную проверку авторизации
  final bool isRegistered = true; // ← поменяй на false для теста

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            isRegistered ? 'хелловерлд' : 'ходу нет',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
