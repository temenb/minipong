class Battle {
  final String id;
  final List<String> characterIds;
  final List<String> characterNames;
  final Map<String, String> idNameHash;
  final List<Score> scores;
  final DateTime createdAt;

  Battle({
    String? id,
    required this.characterIds,
    required this.characterNames,
    required this.idNameHash,
    List<Score>? scores,
    required this.createdAt,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        scores = scores ?? [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'characterIds': List<String>.from(json['characterIds']),
        'characterNames': List<String>.from(json['characterNames']),
        'idNameHash': Map<String, String>.from(json['idNameHash']),
        'scoreIds': _scoreIds,
        'startedAt': startedAt.toIso8601String(),
        'finishedAt': finishedAt?.toIso8601String(),
      };

  static Battle fromJson(Map<String, dynamic> json) => Battle(
        id: json['id'],
        characterIds: List<String>.from(json['characterIds']),
        characterNames: List<String>.from(json['characterNames']),
        idNameHash: Map<String, String>.from(json['idNameHash']),
        scoreIds: List<String>.from(json['scoreIds']),
        startedAt: DateTime.parse(json['startedAt']),
        finishedAt: json['finishedAt'] != null
            ? DateTime.parse(json['finishedAt'])
            : null,
      );

  List<String> get characterIds => _characterIds;
  List<String> get characterNames => _characterNames;
  Map<String, String> get idNameHash => _idNameHash;
  List<String> get scoreIds => _scoreIds;
}
