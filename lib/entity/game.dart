import 'package:minipong/repositories/character_repository.dart';
import 'package:minipong/entity/character.dart';

class Game {
  final String id;
  List<String> characterIds;
  final DateTime createdAt;

  Game({
    required this.id,
    required this.characterIds,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'characterIds': characterIds,
    'createdAt': createdAt.toIso8601String(),
  };

  static Game fromJson(Map<String, dynamic> json) => Game(
    id: json['id'],
    characterIds: List<String>.from(json['characterIds']),
    createdAt: DateTime.parse(json['createdAt']),
  );

  List<Character> get characters =>
      CharacterRepository.instance.characters
          .where((c) => characterIds.contains(c.id))
          .toList();
}
