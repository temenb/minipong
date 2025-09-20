class BattleManager {
  late Battle _battle;

  BattleManager({
    required List<String> characterIds,
    required List<String> characterNames,
  }) {
    assert(characterIds.length == characterNames.length);
    final idNameHash = {
      for (int i = 0; i < characterIds.length; i++) characterIds[i]: characterNames[i],
    };

    _battle = Battle(
      characterIds: characterIds,
      characterNames: characterNames,
      idNameHash: idNameHash,
      createdAt: DateTime.now(),
    );
  }

  Battle get battle => _battle;
  List<Score> get scores => _battle.scores;

  void addPoint(String characterId) {
    final score = Score(
      value: _battle.scores.length + 1,
      characterId: characterId,
    );
    _battle.scores.add(score);
  }

  Map<String, int> get currentScore {
    final result = <String, int>{};
    for (var id in _battle.characterIds) {
      result[id] = 0;
    }
    for (var s in _battle.scores) {
      result[s.characterId] = (result[s.characterId] ?? 0) + 1;
    }
    return result;
  }

  bool get isFinished => currentScore.values.any((v) => v >= 21);

  String? get winnerId => isFinished
      ? currentScore.entries.reduce((a, b) => a.value > b.value ? a : b).key
      : null;
}
