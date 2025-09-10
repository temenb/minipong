class ScoreLogEntry {
  final int player;
  final int delta;
  final DateTime timestamp;

  ScoreLogEntry(this.player, this.delta, [DateTime? ts])
      : timestamp = ts ?? DateTime.now();
}

class GameHistoryEntry {
  final String winner;
  final String loser;
  final List<ScoreLogEntry> scoreLog;

  GameHistoryEntry({required this.winner, required this.loser, required this.scoreLog});

  Map<String, dynamic> toJson() => {
        'winner': winner,
        'loser': loser,
        'scoreLog': scoreLog.map((e) => {
              'player': e.player,
              'delta': e.delta,
              'timestamp': e.timestamp.toIso8601String(),
            }).toList(),
      };

  static GameHistoryEntry fromJson(Map<String, dynamic> json) {
    return GameHistoryEntry(
      winner: json['winner'],
      loser: json['loser'],
      scoreLog: (json['scoreLog'] as List).map((e) => ScoreLogEntry(
        e['player'],
        e['delta'],
        DateTime.parse(e['timestamp']),
      )).toList(),
    );
  }
}

