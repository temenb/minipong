class Battle {
  final String id;
  final List<String> _characterIds;
  final List<String> _scoreIds;
  final DateTime startedAt;
  final DateTime? finishedAt;

  Battle({
    required this.id,
    required List<String> characterIds,
    required List<String> scoreIds,
    required this.startedAt,
    this.finishedAt,
  })  : _characterIds = characterIds,
        _scoreIds = scoreIds;

  Map<String, dynamic> toJson() => {
        'id': id,
        'characterIds': _characterIds,
        'scoreIds': _scoreIds,
        'startedAt': startedAt.toIso8601String(),
        'finishedAt': finishedAt?.toIso8601String(),
      };

  static Battle fromJson(Map<String, dynamic> json) => Battle(
        id: json['id'],
        characterIds: List<String>.from(json['characterIds']),
        scoreIds: List<String>.from(json['scoreIds']),
        startedAt: DateTime.parse(json['startedAt']),
        finishedAt: json['finishedAt'] != null
            ? DateTime.parse(json['finishedAt'])
            : null,
      );

  List<String> get characterIds => _characterIds;
  List<String> get scoreIds => _scoreIds;
}
