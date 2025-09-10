class Battle {
  final String id;
  final List<String> charIds;
  final List<String> scoreIds;
  final DateTime startedAt;
  final DateTime? finishedAt;

  Battle({
    required this.id,
    required this.charIds,
    required this.scoreIds,
    required this.startedAt,
    this.finishedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'charIds': charIds,
    'scoreIds': scoreIds,
    'startedAt': startedAt.toIso8601String(),
    'finishedAt': finishedAt?.toIso8601String(),
  };

  static Battle fromJson(Map<String, dynamic> json) => Battle(
    id: json['id'],
    charIds: List<String>.from(json['charIds']),
    scoreIds: List<String>.from(json['scoreIds']),
    startedAt: DateTime.parse(json['startedAt']),
    finishedAt: json['finishedAt'] != null ? DateTime.parse(json['finishedAt']) : null,
  );
}

