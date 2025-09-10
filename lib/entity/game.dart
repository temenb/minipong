class Game {
  final String id;
  final List<String> matchIds;
  final DateTime createdAt;

  Game({
    required this.id,
    required this.matchIds,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'matchIds': matchIds,
    'createdAt': createdAt.toIso8601String(),
  };

  static Game fromJson(Map<String, dynamic> json) => Game(
    id: json['id'],
    matchIds: List<String>.from(json['matchIds']),
    createdAt: DateTime.parse(json['createdAt']),
  );
}
import 'package:minipong/entity/match.dart';

class MatchRepository {
  static final MatchRepository instance = MatchRepository._internal();
  MatchRepository._internal();

  final List<Match> _matches = [];

  List<Match> get matches => List.unmodifiable(_matches);

  void addMatch(Match match) {
    _matches.add(match);
  }

  Match? getMatchById(String id) {
    return _matches.firstWhere((m) => m.id == id, orElse: () => null);
  }

  void removeMatch(String id) {
    _matches.removeWhere((m) => m.id == id);
  }

  void clear() {
    _matches.clear();
  }
}
import 'package:minipong/entity/score.dart';

class ScoreRepository {
  static final ScoreRepository instance = ScoreRepository._internal();
  ScoreRepository._internal();

  final List<Score> _scores = [];

  List<Score> get scores => List.unmodifiable(_scores);

  void addScore(Score score) {
    _scores.add(score);
  }

  Score? getScoreById(String id) {
    return _scores.firstWhere((s) => s.id == id, orElse: () => null);
  }

  void removeScore(String id) {
    _scores.removeWhere((s) => s.id == id);
  }

  void clear() {
    _scores.clear();
  }
}

