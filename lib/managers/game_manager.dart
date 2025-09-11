import 'package:flutter/foundation.dart';
import 'package:minipong/entity/game.dart';
import 'package:minipong/entity/character.dart';
import 'package:minipong/repositories/match_repository.dart';
import 'package:minipong/repositories/character_repository.dart';

class GameManager extends ChangeNotifier {
  Game? _currentGame;

  GameManager() {
    init();
  }

  void reset() {
    _currentGame = Game(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      characterIds: [],
      createdAt: DateTime.now(),
    );
    notifyListeners();
  }

  /// Сброс состояния игры
  Future<void> init() async {
    reset();
    try {
      await CharacterRepository.instance.getAll();

      print('=====================================================================================================================');
      print('GameManager.init: ��олучены персонажи:');
      for (final c in CharacterRepository.instance.characters) {
        print('id: \'${c.id}\', name: \'${c.name}\'');
      }
    } catch (e, s) {
      print('=====================================================================================================================');
      print('GameManager.init: error: $e\n$s');
    }
  }

  Game? get currentGame => _currentGame;

/// Создание нового матча с выбранными персонажами
// void createNewMatch(List<Character> characters) {
//     id: DateTime.now().millisecondsSinceEpoch.toString(),
//     battleIds: [],
//     createdAt: DateTime.now(),
//   );
//   _selectedCharacters
//     ..clear()
//     ..addAll(characters);
//   MatchRepository.instance.addMatch(newMatch);
// }

// void createNewGame() {
//   _currentGame = Game(
//     id: DateTime.now().millisecondsSinceEpoch.toString(),
//     characterIds: activePlayerIds.toList(),
//     createdAt: DateTime.now(),
//   );
// }
//
// void setPlayerActive(String id, bool active) {
// }
//
// void addPlayer(Character character) {
//   CharacterRepository.instance.addCharacter(character);
//   activePlayerIds.add(character.id);
//   updateCurrentGameCharacterIds();
//
// void removePlayer(String id) {
//   CharacterRepository.instance.removeById(id);
//   activePlayerIds.remove(id);
//   updateCurrentGameCharacterIds();
// }
}
