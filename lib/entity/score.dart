class Score {
  final String id;
  final int value;
  final String gameId;

  Score({required this.id, required this.value, required this.gameId});

  Map<String, dynamic> toJson() => {
    'id': id,
    'value': value,
    'gameId': gameId,
  };

  static Score fromJson(Map<String, dynamic> json) => Score(
    id: json['id'],
    value: json['value'],
    gameId: json['gameId'],
  );
}

