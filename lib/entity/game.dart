class Game {
  final String id;
  final List<String> charIds;
  final DateTime createdAt;

  Game({
    required this.id,
    required this.charIds,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'charIds': charIds,
    'createdAt': createdAt.toIso8601String(),
  };

  static Game fromJson(Map<String, dynamic> json) => Game(
    id: json['id'],
    charIds: List<String>.from(json['charIds']),
    createdAt: DateTime.parse(json['createdAt']),
  );
}

