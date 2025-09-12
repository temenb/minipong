import 'package:minipong/entity/character.dart';
import 'package:minipong/repositories/repository.dart';
import 'package:minipong/services/app_logger.dart';
import 'package:minipong/services/storage_service.dart';

class CharacterRepository extends Repository<Character> {
  static final CharacterRepository instance = CharacterRepository._internal();
  CharacterRepository._internal();

  List<Character> get characters => items;

  void addCharacter(Character character) {
    add(character);
  }

  @override
  Character? getById(String id) {
    try {
      return items.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  void removeById(String id) {
    final index = items.indexWhere((c) => c.id == id);
    if (index == -1) {
      return;
    }
    remove(index);
  }

  void clear() {
    super.clear();
  }
}
