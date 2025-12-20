import 'battle.dart';

class Match {
  final String id;
  final List<String> _battleIds;
  final DateTime createdAt;

  Match({
    String? id,
    required List<String> battleIds,
    required this.createdAt,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
       _battleIds = battleIds;

  Map<String, dynamic> toJson() => {
    'id': id,
    'battleIds': _battleIds,
    'createdAt': createdAt.toIso8601String(),
  };

  static Match fromJson(Map<String, dynamic> json) => Match(
    id: json['id'],
    battleIds: List<String>.from(json['battleIds']),
    createdAt: DateTime.parse(json['createdAt']),
  );

  List<String> get battleIds => _battleIds;
}
