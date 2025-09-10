class Score {
  final String id;
  final int value;
  final String charId;

  Score({required this.id, required this.value, required this.charId});

  Map<String, dynamic> toJson() => {
    'id': id,
    'value': value,
    'charId': charId,
  };

  static Score fromJson(Map<String, dynamic> json) => Score(
    id: json['id'],
    value: json['value'],
    charId: json['charId'],
  );
}

