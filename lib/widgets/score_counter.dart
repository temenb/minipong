import 'package:flutter/material.dart';
import 'package:minipong/entity/game.dart';
import 'package:minipong/entity/character.dart';
import 'package:minipong/widgets/user_score.dart';

class ScoreCounter extends StatefulWidget {
  final Game game;
  const ScoreCounter({Key? key, required this.game}) : super(key: key);

  @override
  State<ScoreCounter> createState() => _ScoreCounterState();
}

class _ScoreCounterState extends State<ScoreCounter> {
  int score1 = 0;
  int score2 = 0;
  Character? selected1;
  Character? selected2;

  @override
  Widget build(BuildContext context) {
    final characters = widget.game.characters;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: UserScore(
              characters: characters,
              selected: selected1,
              score: score1,
              onPlayerChanged: (val) => setState(() => selected1 = val),
              onAdd: () => setState(() => score1++),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: UserScore(
              characters: characters,
              selected: selected2,
              score: score2,
              onPlayerChanged: (val) => setState(() => selected2 = val),
              onAdd: () => setState(() => score2++),
            ),
          ),
        ),
      ],
    );
  }
}
