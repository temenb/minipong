class Match {
  final String id;
  final List<Battle> battle;
  final DateTime createdAt;
  final DateTime createdAt;

  Match({
    required this.id,
    required this.battleIds,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'battleIds': battleIds,
    'createdAt': createdAt.toIso8601String(),
  };

  static Match fromJson(Map<String, dynamic> json) => Match(
    id: json['id'],
    battleIds: List<String>.from(json['battleIds']),
    createdAt: DateTime.parse(json['createdAt']),
  );
}
