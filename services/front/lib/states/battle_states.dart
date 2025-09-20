class BattleState {
  final List<Score> scores;
  final Map<String, int> currentScore;
  final bool isFinished;
  final String? winnerId;
  final Map<String, String> idNameHash;

  BattleState({
    required this.scores,
    required this.currentScore,
    required this.isFinished,
    required this.idNameHash,
    this.winnerId,
  });

  BattleState copyWith({
    List<Score>? scores,
    Map<String, int>? currentScore,
    bool? isFinished,
    String? winnerId,
    Map<String, String>? idNameHash,
  }) {
    return BattleState(
      scores: scores ?? this.scores,
      currentScore: currentScore ?? this.currentScore,
      isFinished: isFinished ?? this.isFinished,
      winnerId: winnerId ?? this.winnerId,
      idNameHash: idNameHash ?? this.idNameHash,
    );
  }

  factory BattleState.initial(Map<String, String> idNameHash) => BattleState(
    scores: [],
    currentScore: {},
    isFinished: false,
    winnerId: null,
    idNameHash: idNameHash,
  );
}
