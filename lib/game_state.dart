import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:minipong/player_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/game_models.dart';
import 'repositories/game_history_repository.dart';
import 'services/audio_service.dart';

class GameState {
  static final GameState instance = GameState._internal();
  GameState._internal();

  final GameHistoryRepository gameHistoryRepository = GameHistoryRepository();
  final AudioService audioService = AudioService();
  final PlayerRepository playerRepository = PlayerRepository.instance;

  List<ScoreLogEntry> scoreLog = [];
  List<GameHistoryEntry> savedGames = [];
  List<GameHistoryEntry> sessionGames = [];
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
    return serverPlayer;
  }

  int get secPlayer {
    return firPlayer == 1 ? 0 : 1;
  }

  int get serverPlayer {
    int scoreLimit = _scoreOptions[selectedScore] - 1;
    bool moreOrLess = (totalScore >= 2*scoreLimit);

    int score = moreOrLess? totalScore - 2*scoreLimit : totalScore;
    int pointsPerServeSwitch = moreOrLess? 1 : _serveSwitchModes[selectedScore];
    int switches = (score ~/ pointsPerServeSwitch) % 2;
    return switches;
  }

  int get receiverPlayer {
    return serverPlayer == 1 ? 0 : 1;
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
    savedGames = await gameHistoryRepository.loadSavedGames();
    sessionGames = [];
  }

  Future<void> saveCurrentGame() async {
    String winner = player1Score > player2Score ? (players.isNotEmpty ? players[0] : 'Player 1') : (players.length > 1 ? players[1] : 'Player 2');
    String loser = player1Score < player2Score ? (players.isNotEmpty ? players[0] : 'Player 1') : (players.length > 1 ? players[1] : 'Player 2');
    final entry = GameHistoryEntry(
      winner: winner,
      loser: loser,
      scoreLog: List<ScoreLogEntry>.from(scoreLog),
    );
    await gameHistoryRepository.saveCurrentGame(entry);
    savedGames.insert(0, entry);
    sessionGames.insert(0, entry);
    scoreLog.clear();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  DateTime? _lastGoalTime;

  Future<void> addGoalToPlayer(int playerNum) async {
    final now = DateTime.now();
    if (_lastGoalTime != null && now.difference(_lastGoalTime!).inMilliseconds < 2000) {
      // return;
    }
    _lastGoalTime = now;

    scoreLog.add(ScoreLogEntry(playerNum, 1));
    await audioService.playPing(playerNum);

    print('============================================================================================================================================');
    print('[DEBUG] addGoalToPlayer: playerNum=$playerNum, player1Score=$player1Score, player2Score=$player2Score, totalScore=$totalScore');
    print('[DEBUG] players: $players');
    print('[DEBUG] firPlayer: $firPlayer, secPlayer: $secPlayer');
    print('[DEBUG] isGameFinished: ${isGameFinished()}');
    if (isGameFinished()) {
      await saveGameAndSwitchPlayers();
    }
  }

  Future<void> saveGameAndSwitchPlayers() async {
    // int p1Score = player1Score;
    // int p2Score = player2Score;
    // int winnerIdx = p1Score > p2Score ? 0 : 1;
    // int loserIdx = p1Score > p2Score ? 1 : 0;
    // String winner = players[winnerIdx];
    // String loser = players[loserIdx];

    await saveCurrentGame();
    reset();

    // // Победитель становится первым
    // setSelectedPlayer1(winner);
    // // Найти следующего активного игрока после проигравшего
    // final activePlayers = activePlayerNames;
    // int loserActiveIdx = activePlayers.indexOf(loser);
    // String nextPlayer;
    // if (loserActiveIdx != -1 && loserActiveIdx + 1 < activePlayers.length) {
    //   nextPlayer = activePlayers[loserActiveIdx + 1];
    // } else {
    //   nextPlayer = loser;
    // }
    // setSelectedPlayer1(nextPlayer);
  }


  void deleteLogEntry(int index) {

    if (index >= 0 && index < scoreLog.length) {
      scoreLog.removeAt(index);
    }
  }

  bool isGameFinished() {
    bool finished = (
        player1Score >= _scoreOptions[_selectedScore] ||
        player2Score >= _scoreOptions[_selectedScore]
    ) && ((player1Score - player2Score).abs() >= 2);
    return finished;
  }

  void init() {
    reset();
    _selectedScore = 1;
    final active = playerRepository.activePlayerNames;
    players = [];
    if (active.isNotEmpty) players.add(active[0]);
    if (active.length > 1) players.add(active[1]);
    sessionGames.clear(); // очищаем историю игр текущей сессии
  }

  void reset() {
    scoreLog.clear();
  }

  List<String> get activePlayerNames => playerRepository.activePlayerNames;
}
