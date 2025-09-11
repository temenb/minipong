import 'package:minipong/entity/character.dart';
import 'package:minipong/repositories/repository.dart';
import 'package:minipong/repositories/storage_service.dart';

class CharacterRepository extends Repository<Character> {
  static final CharacterRepository instance = CharacterRepository._internal();
  CharacterRepository._internal();

  List<Character> get characters => items;

  void addCharacter(Character character) {
    add(character);
    persist();
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
    persist();
  }

  void clear() {
    super.clear();
    persist();
  }

  /// Сохраняет текущий список персонажей в StorageService
  Future<void> persist() async {
    print('====================================================================================================================');
    print('CharacterRepository.persist: сохраняем игроков:');
    for (final c in items) {
      print('id: \'${c.id}\', name: \'${c.name}\'');
    }
    await StorageService.instance.saveList(
      'characters',
      items.map((c) => c.toJson()).toList(),
    );
  }

  /// Загружает список матчей из StorageService и обновляет items
  Future<void> getAll() async {
    // final list = await StorageService.instance.loadList('characters');
    // clear();
    // addAll(list.map((json) => Character.fromJson(json)));

    final list = <Character>[
      Character(id: '1', name: 'character 1'),
      Character(id: '2', name: 'character 2'),
      Character(id: '3', name: 'character 3'),
    ];
    clear();
    addAll(list);

    print('====================================================================================================================');
    print('CharacterRepository.getAll: сохр��няем игроков:');
    for (final c in items) {
      print('id: \'${c.id}\', name: \'${c.name}\'');
    }
  }
}
