import 'package:flutter/foundation.dart';
import 'package:minipong/entity/match.dart';
import 'package:minipong/entity/char.dart';
import 'package:minipong/repositories/match_repository.dart';
import 'package:minipong/repositories/chars_repository.dart';

class GameManager extends ChangeNotifier {
  List<Match> get matches => MatchRepository.instance.matches;
  List<Char> get chars => CharRepository.instance.chars;

  Match? _currentMatch;
  final List<Char> _selectedChars = [];
  final Set<String> activePlayerIds = {};

  GameManager() {
    init();
  }

  void reset() {
    _currentMatch = null;
    _selectedChars.clear();
    notifyListeners();
  }

  /// Сброс состояния игры
  Future<void> init() async {
    reset();
    await CharRepository.instance.getAll();
    notifyListeners();
  }

  Match? get currentMatch => _currentMatch;
  List<Char> get selectedChars => List.unmodifiable(_selectedChars);

  /// Создание нового матча с выбранными персонажами
  void createNewMatch(List<Char> chars) {
    final newMatch = Match(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      battleIds: [],
      createdAt: DateTime.now(),
    );
    _currentMatch = newMatch;
    _selectedChars
      ..clear()
      ..addAll(chars);
    MatchRepository.instance.addMatch(newMatch);
    notifyListeners();
  }

  bool isPlayerActive(String id) => activePlayerIds.contains(id);

  void setPlayerActive(String id, bool active) {
    if (active) {
      activePlayerIds.add(id);
    } else {
      activePlayerIds.remove(id);
    }
    notifyListeners();
  }

  void addPlayer(Char char) {
    CharRepository.instance.addChar(char);
    activePlayerIds.add(char.id);
    notifyListeners();
  }

  void removePlayer(String id) {
    CharRepository.instance.remove(id);
    activePlayerIds.remove(id);
    notifyListeners();
  }
}
