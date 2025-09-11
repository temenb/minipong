import 'package:flutter/foundation.dart';
import 'package:minipong/entity/match.dart';
import 'package:minipong/entity/character.dart';
import 'package:minipong/repositories/match_repository.dart';
import 'package:minipong/repositories/character_repository.dart';

class GameManager extends ChangeNotifier {
  List<Match> get matches => MatchRepository.instance.matches;
  List<Character> get characters => CharacterRepository.instance.characters;

  Match? _currentMatch;
  final List<Character> _selectedCharacters = [];
  final Set<String> activePlayerIds = {};

  GameManager() {
    init();
  }

  void reset() {
    _currentMatch = null;
    _selectedCharacters.clear();
    notifyListeners();
  }

  /// Сброс состояния игры
  Future<void> init() async {
    reset();
    try {
      await CharacterRepository.instance.getAll();
    } catch (e, s) {
      print('=====================================================================================================================');
      print('GameManager.init: error: $e\n$s');
    }
    notifyListeners();
  }

  Match? get currentMatch => _currentMatch;
  List<Character> get selectedCharacters => List.unmodifiable(_selectedCharacters);

  /// Создание нового матча с выбранными персонажами
  void createNewMatch(List<Character> characters) {
    final newMatch = Match(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      battleIds: [],
      createdAt: DateTime.now(),
    );
    _currentMatch = newMatch;
    _selectedCharacters
      ..clear()
      ..addAll(characters);
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

  void addPlayer(Character character) {
    CharacterRepository.instance.addCharacter(character);
    activePlayerIds.add(character.id);
    notifyListeners();
  }

  void removePlayer(String id) {
    CharacterRepository.instance.removeById(id);
    activePlayerIds.remove(id);
    notifyListeners();
  }
}
