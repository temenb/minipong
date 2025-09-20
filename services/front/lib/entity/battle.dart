import 'dart:convert';

class Battle {
  final String id;
  final String matchId;
  final Map<String, String> storedCharacters;
  final DateTime createdAt;
  final DateTime? finishedAt;

  Battle({
    String? id,
    required this.matchId,
    required List<String> characterIds,
    required List<String> characterNames,
    required this.createdAt,
    this.finishedAt,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        storedCharacters = Map<String, String>.fromIterables(characterIds, characterNames);

  Map<String, dynamic> toJson() => {
        'id': id,
        'matchId': matchId,
        'storedCharacters': storedCharacters,
        'createdAt': createdAt.toIso8601String(),
        'finishedAt': finishedAt?.toIso8601String(),
      };

  static Battle fromJson(Map<String, dynamic> json) {
    final storedCharacters = Map<String, String>.from(json['storedCharacters']);
    return Battle(
      id: json['id'],
      matchId: json['matchId'],
      characterIds: storedCharacters.keys.toList(),
      characterNames: storedCharacters.values.toList(),
      createdAt: DateTime.parse(json['createdAt']),
      finishedAt: json['finishedAt'] != null ? DateTime.parse(json['finishedAt']) : null,
    );
  }

  List<String> get characterIds => storedCharacters.keys.toList();
  List<String> get characterNames => storedCharacters.values.toList();
}
