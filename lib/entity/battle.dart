class Battle {
  final String id;
  final List<String> characterIds;
  final List<String> scoreIds;
  final DateTime startedAt;
  final DateTime? finishedAt;

  Battle({
    required this.id,
    required this.characterIds,
    required this.scoreIds,
    required this.startedAt,
    this.finishedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'characterIds': characterIds,
    'scoreIds': scoreIds,
    'startedAt': startedAt.toIso8601String(),
    'finishedAt': finishedAt?.toIso8601String(),
  };

  static Battle fromJson(Map<String, dynamic> json) => Battle(
    id: json['id'],
    characterIds: List<String>.from(json['characterIds']),
    scoreIds: List<String>.from(json['scoreIds']),
    startedAt: DateTime.parse(json['startedAt']),
    finishedAt: json['finishedAt'] != null ? DateTime.parse(json['finishedAt']) : null,
  );
}

