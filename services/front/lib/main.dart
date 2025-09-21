import 'package:flutter/material.dart';
import 'package:minipong/feature/profile/presentation/profile_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileListScreen(),
    );
  }
}
