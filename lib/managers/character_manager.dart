import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:minipong/entity/character.dart';
import 'package:minipong/repositories/character_repository.dart';
import 'package:minipong/services/storage_service.dart';
import 'package:minipong/managers/game_manager.dart';

class CharacterManager extends ChangeNotifier {
  final CharacterRepository _repository = CharacterRepository.instance;
  final Logger logger = Logger();

  CharacterManager();

  /// Публичный геттер для получения всех персонажей
  List<Character> get characters => _repository.characters;

  Future<void> initCharacters() async {
    await getAllFromStorage();
    logger.d('CharacterManager.initCharacters: получены персонажи:');
    for (final c in _repository.characters) {
      logger.d("id: '${c.id}', name: '${c.name}'");
    }
    notifyListeners();
  }

  void addCharacter(String name) {
    final character = Character(name: name);
    logger.d('CharacterManager.addCharacter: добавляем персонаца: id=${character
        .id}, name=${character.name}');
    _repository.addCharacter(character);
    persist();
    notifyListeners();
  }

  void removeCharacter(String id) {
    _repository.removeById(id);
    StorageService.instance.saveList(
      'characters',
      _repository.characters.map((c) => c.toJson()).toList(),
    );
    notifyListeners();
  }

  void renameCharacter(String id, String newName) {
    final character = _repository.getById(id);
    if (character != null) {
      character.name = newName;
      persist();
      notifyListeners();
    }
  }

  /// Сохраняет текущий список персонажей в StorageService
  Future<void> persist() async {
    logger.d('CharacterManager.persist: сохраняем игроков:');
    for (final c in _repository.characters) {
      logger.d("id: '${c.id}', name: '${c.name}'");
    }
    await StorageService.instance.saveList(
      'characters',
      _repository.characters.map((c) => c.toJson()).toList(),
    );
  }

  /// Загружает список персонажей из StorageService и обновляет characters
  Future<void> getAllFromStorage() async {
    final list = await StorageService.instance.loadList('characters');
    _repository.clear();
    _repository.addAll(list.map((json) => Character.fromJson(json)));

    logger.d('CharacterManager.getAllFromStorage: получаем игроков:');
    for (final c in _repository.characters) {
      logger.d("id: '${c.id}', name: '${c.name}'");
    }
    notifyListeners();
  }

  void moveCharacterUp(String id, GameManager gameManager) {
    _moveCharacter(id, 1, gameManager);
  }

  void moveCharacterDown(String id, GameManager gameManager) {
    _moveCharacter(id, -1, gameManager);
  }

  void _moveCharacter(String id, int direction, GameManager gameManager) {
    int index = _repository.characters.indexWhere((c) => c.id == id);
    if (direction == 0) return;
    if (index == -1) return;
    final currentGame = gameManager?.currentGame;
    if (currentGame == null) return;
    final currentGameIds = currentGame.characterIds;
    if (currentGameIds.isEmpty) return;

    logger.d(index);
    // Создаём изменяемую копию списка персонажей
    final mutableCharacters = List<Character>.from(_repository.characters);
    int step = (direction > 0) ? 1 : -1;
    for (int i = index; i >= 0 && i < mutableCharacters.length; i -= step) {
      if (i == index) continue;
      if (currentGameIds.contains(mutableCharacters[i].id)) {
        // Меняем местами с найденным персонажем
        final tmp = mutableCharacters[index];
        mutableCharacters[index] = mutableCharacters[i];
        mutableCharacters[i] = tmp;
        _repository.clear();
        _repository.addAll(mutableCharacters);
        persist();
        notifyListeners();
        return;
      }
    }
  }
}
