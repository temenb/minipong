class Score {
  final String id;
  final int value;
  final String _characterId;

  Score({required this.id, required this.value, required String characterId})
      : _characterId = characterId;

  Map<String, dynamic> toJson() => {
    'id': id,
    'value': value,
    'characterId': _characterId,
  };

  static Score fromJson(Map<String, dynamic> json) => Score(
    id: json['id'],
    value: json['value'],
    characterId: json['characterId'],
  );

  String get characterId => _characterId;
}
