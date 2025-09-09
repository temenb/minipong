import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ScoreLogEntry {
  final int player;
  final int delta;
  final DateTime timestamp;
  ScoreLogEntry(this.player, this.delta, [DateTime? ts]) : timestamp = ts ?? DateTime.now();
}

class GameState {
  List<ScoreLogEntry> scoreLog = [];
  List<List<ScoreLogEntry>> savedGames = [];
  List<List<ScoreLogEntry>> sessionGames = [];
  List<String> players = [];
  String? selectedPlayer1;
  String? selectedPlayer2;
  int serveSwitchMode = 5;
  bool lock = false;
  int? _firstServer; // 1 или 2

  int get player1Score => scoreLog.where((e) => e.player == 1).fold(0, (sum, e) => sum + e.delta);
  int get player2Score => scoreLog.where((e) => e.player == 2).fold(0, (sum, e) => sum + e.delta);
  int get totalScore => scoreLog.fold(0, (sum, e) => sum + e.delta);
  int get firPlayer {
    if (lock || scoreLog.isEmpty) {
      return 1;
    }
    // Если замок открыт, вычисляем по serveSwitchMode
    int switches = (totalScore ~/ serveSwitchMode) % 2;
    // Если switches чётное — первый подающий, нечётное — второй
    return switches == 0 ? _firstServer! : (_firstServer == 1 ? 2 : 1);
  }
  int get secPlayer {
    return firPlayer == 1 ? 2 : 1;
  }
  int get greenPlayer => firPlayer;
  int get pinkPlayer => secPlayer;


  Future<void> loadPlayers() async {
    final prefs = await SharedPreferences.getInstance();
    final loadedPlayers = prefs.getStringList('players') ?? [];
    players = loadedPlayers;
    if (players.length >= 2) {
      selectedPlayer1 ??= players[0];
      selectedPlayer2 ??= players[1];
    } else {
      selectedPlayer1 = null;
      selectedPlayer2 = null;
    }
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
    selectedPlayer1 = name;
  }

  void setSelectedPlayer2(String name) {
    selectedPlayer2 = name;
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

  void setServeSwitchMode(int mode) {
    serveSwitchMode = mode;
  }

  void addGoalToPlayer(int playerNum) {
    scoreLog.add(ScoreLogEntry(playerNum, 1));
    // После первого гола запоминаем первого подающего
    if (_firstServer == null) {
      _firstServer = playerNum;
    }
  }

  void deleteLogEntry(int index) {
    if (index >= 0 && index < scoreLog.length) {
      scoreLog.removeAt(index);
      // Если после удаления нет голов, сбрасываем выбранных игроков и первого подающего
      if (scoreLog.isEmpty) {
        selectedPlayer1 = null;
        selectedPlayer2 = null;
        _firstServer = null;
      } else {
        // Перезаписываем первого подающего по первому голу
        _firstServer = scoreLog.first.player;
      }
    }
  }
}
