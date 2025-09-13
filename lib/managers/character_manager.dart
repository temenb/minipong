import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:minipong/entity/character.dart';
import 'package:minipong/repositories/character_repository.dart';
import 'package:minipong/services/storage_service.dart';

class CharacterManager extends ChangeNotifier {
  final CharacterRepository _repository = CharacterRepository.instance;
  final Logger logger = Logger();

  List<Character> get characters => _repository.characters;

  Future<void> initCharacters() async {
    await getAllFromStorage();
    logger.d('CharacterManager.initCharacters: получены персонажи:');
    for (final c in characters) {
      logger.d("id: '${c.id}', name: '${c.name}'");
    }
    notifyListeners();
  }

  void addCharacter(String name) {
    final character = Character(name: name);
    logger.d('CharacterManager.addCharacter: добавляем персонажа: id=${character.id}, name=${character.name}');
    _repository.addCharacter(character);
    persist();
    notifyListeners();
  }

  void removeCharacter(String id) {
    _repository.removeById(id);
    StorageService.instance.saveList(
      'characters',
      characters.map((c) => c.toJson()).toList(),
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
    for (final c in characters) {
      logger.d("id: '${c.id}', name: '${c.name}'");
    }
    await StorageService.instance.saveList(
      'characters',
      characters.map((c) => c.toJson()).toList(),
    );
  }

  /// Загружает список персонажей из StorageService и обновляет characters
  Future<void> getAllFromStorage() async {
    final list = await StorageService.instance.loadList('characters');
    _repository.clear();
    _repository.addAll(list.map((json) => Character.fromJson(json)));

    // final list = <Character>[
    //   Character(id: '1', name: 'character 1'),
    //   Character(id: '2', name: 'character 2'),
    //   Character(id: '3', name: 'character 3'),
    // ];
    // clear();
    // addAll(list);

    logger.d('CharacterManager.getAllFromStorage: получаем игроков:');
    for (final c in characters) {
      logger.d("id: '${c.id}', name: '${c.name}'");
    }
    notifyListeners();
  }
}

