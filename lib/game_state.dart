import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ScoreLogEntry {
  final int player;
  final int delta;
  final DateTime timestamp;
  ScoreLogEntry(this.player, this.delta, [DateTime? ts]) : timestamp = ts ?? DateTime.now();
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
  int _selectedScore = 21;
  int serveSwitchMode = 5;

  List<int> get scoreOptions => List.unmodifiable(_scoreOptions);

  int get player1Score => scoreLog.where((e) => e.player == 1).fold(0, (sum, e) => sum + e.delta);
  int get player2Score => scoreLog.where((e) => e.player == 2).fold(0, (sum, e) => sum + e.delta);
  int get totalScore => scoreLog.fold(0, (sum, e) => sum + e.delta);
  int get firPlayer {
    if (lock) {
      return 0;
    }
    // Если замок открыт, вычисляем по serveSwitchMode
    int switches = (totalScore ~/ serveSwitchMode) % 2;
    // Если switches чётное — первый подающий, нечётное — второй
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
    if (players.isNotEmpty) players[0] = name;
  }

  void setSelectedPlayer2(String name) {
    if (players.length > 1) players[1] = name;
  }

  Future<void> loadSavedGames() async {
    final prefs = await SharedPreferences.getInstance();
    final gamesJson = prefs.getStringList('savedGames') ?? [];
    savedGames = gamesJson.map((game) {
      final list = jsonDecode(game) as List;
      return list.map((e) => ScoreLogEntry(e['player'], e['delta'], DateTime.parse(e['timestamp']))).toList();
    }).toList();
    sessionGames = [];
  }

  Future<void> saveCurrentGame() async {
    final prefs = await SharedPreferences.getInstance();
    final game = scoreLog.map((e) => {
      'player': e.player,
      'delta': e.delta,
      'timestamp': e.timestamp.toIso8601String(),
    }).toList();
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

  int get selectedScore => _selectedScore;
  set selectedScore(int value) {
    _selectedScore = value;
    serveSwitchMode = (value == 11) ? 2 : 5;
  }
}
