class Score {
  final String id;
  final int value;
  final String characterId;

  Score({required this.id, required this.value, required this.characterId});

  Map<String, dynamic> toJson() => {
    'id': id,
    'value': value,
    'characterId': characterId,
  };

  static Score fromJson(Map<String, dynamic> json) => Score(
    id: json['id'],
    value: json['value'],
    characterId: json['characterId'],
  );
}

