import 'dart:convert';

import 'package:minipong/player_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreLogEntry {
  final int player;
  final int delta;
  final DateTime timestamp;

  ScoreLogEntry(this.player, this.delta, [DateTime? ts])
    : timestamp = ts ?? DateTime.now();
}

class GameState {
  static final GameState instance = GameState._internal();

  GameState._internal();

  List<ScoreLogEntry> scoreLog = [];
  List<List<ScoreLogEntry>> savedGames = [];
  List<List<ScoreLogEntry>> sessionGames = [];
  List<String> players = [];
  bool lock = false;
  final List<int> _scoreOptions = [11, 21, 31];
  final List<int> _serveSwitchModes = [2, 5, 5];
  int _selectedScore = 1; // теперь это индекс

  List<int> get scoreOptions => List.unmodifiable(_scoreOptions);

  int get selectedScore => _selectedScore;

  set selectedScore(int index) {
    if (index < 0 || index >= _scoreOptions.length) return;
    _selectedScore = index;
  }

  int get serveSwitchMode => _serveSwitchModes[_selectedScore];

  int get player1Score =>
      scoreLog.where((e) => e.player == 1).fold(0, (sum, e) => sum + e.delta);

  int get player2Score =>
      scoreLog.where((e) => e.player == 2).fold(0, (sum, e) => sum + e.delta);

  int get totalScore => scoreLog.fold(0, (sum, e) => sum + e.delta);

  int get firPlayer {
    if (lock) {
      return 0;
    }
    int switches = (totalScore ~/ serveSwitchMode) % 2;
    return switches;
  }

  int get secPlayer {
    return firPlayer == 1 ? 0 : 1;
  }

  int get greenPlayer {
    int switches = (totalScore ~/ serveSwitchMode) % 2;
    return switches;
  }

  int get pinkPlayer {
    return greenPlayer == 1 ? 0 : 1;
  }

  Future<void> loadPlayers() async {
    final prefs = await SharedPreferences.getInstance();
    final loadedPlayers = prefs.getStringList('players') ?? [];
    players = loadedPlayers;
  }

  Future<void> addPlayer(int index, String name) async {
    if (name.trim().isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    while (players.length <= index) {
      players.add('');
    }
    players[index] = name;
    await prefs.setStringList('players', players);
  }

  void setSelectedPlayer1(String name) {
    if (totalScore > 0) return;
    if (players.isNotEmpty) players[0] = name;
  }

  void setSelectedPlayer2(String name) {
    if (totalScore > 0) return;
    if (players.length > 1) players[1] = name;
  }

  Future<void> loadSavedGames() async {
    final prefs = await SharedPreferences.getInstance();
    final gamesJson = prefs.getStringList('savedGames') ?? [];
    savedGames = gamesJson.map((game) {
      final list = jsonDecode(game) as List;
      return list
          .map(
            (e) => ScoreLogEntry(
              e['player'],
              e['delta'],
              DateTime.parse(e['timestamp']),
            ),
          )
          .toList();
    }).toList();
    sessionGames = [];
  }

  Future<void> saveCurrentGame() async {
    final prefs = await SharedPreferences.getInstance();
    final game = scoreLog
        .map(
          (e) => {
            'player': e.player,
            'delta': e.delta,
            'timestamp': e.timestamp.toIso8601String(),
          },
        )
        .toList();
    final gamesJson = prefs.getStringList('savedGames') ?? [];
    gamesJson.add(jsonEncode(game));
    await prefs.setStringList('savedGames', gamesJson);
    savedGames.add(List<ScoreLogEntry>.from(scoreLog));
    sessionGames.add(List<ScoreLogEntry>.from(scoreLog));
    scoreLog.clear();
  }

  void addGoalToPlayer(int playerNum) {
    scoreLog.add(ScoreLogEntry(playerNum, 1));
  }

  void deleteLogEntry(int index) {
    if (index >= 0 && index < scoreLog.length) {
      scoreLog.removeAt(index);
    }
  }

  bool isGameFinished() {
    return totalScore >= _scoreOptions[_selectedScore];
  }

  void reset() {
    scoreLog.clear();
    _selectedScore = 1;
    // Заполняем players первыми двумя активными игроками
    final active = playerRepository.activePlayerNames;
    players = [];
    if (active.isNotEmpty) players.add(active[0]);
    if (active.length > 1) players.add(active[1]);
  }

  final PlayerRepository playerRepository = PlayerRepository.instance;

  List<String> get activePlayerNames => playerRepository.activePlayerNames;
}
