class Game {
  final String id;
  final List<String> characteracterIds;
  final DateTime createdAt;

  Game({
    required this.id,
    required this.characteracterIds,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'characteracterIds': characteracterIds,
    'createdAt': createdAt.toIso8601String(),
  };

  static Game fromJson(Map<String, dynamic> json) => Game(
    id: json['id'],
    characteracterIds: List<String>.from(json['characteracterIds']),
    createdAt: DateTime.parse(json['createdAt']),
  );
}

