import 'package:minipong/repositories/character_repository.dart';
import 'package:minipong/entity/character.dart';
import 'package:flutter/foundation.dart';

class Game {
  final String id;
  List<String> _characterIds;
  final DateTime createdAt;

  Game({
    required this.id,
    required List<String> characterIds,
    required this.createdAt,
  }) : _characterIds = characterIds;

  Map<String, dynamic> toJson() => {
    'id': id,
    'characterIds': _characterIds,
    'createdAt': createdAt.toIso8601String(),
  };

  static Game fromJson(Map<String, dynamic> json) => Game(
    id: json['id'],
    characterIds: List<String>.from(json['characterIds']),
    createdAt: DateTime.parse(json['createdAt']),
  );

  List<Character> get characters =>
      CharacterRepository.instance.characters
          .where((c) => _characterIds.contains(c.id))
          .toList();

  List<String> get characterIds {
    debugPrint('[Game] characterIds requested: $_characterIds');
    return _characterIds;
  }
}
