import 'package:minipong/entity/char.dart';
import 'package:minipong/repositories/repository.dart';
import 'package:minipong/repositories/storage_service.dart';

class CharRepository extends Repository<Char> {
  static final CharRepository instance = CharRepository._internal();
  CharRepository._internal();

  List<Char> get chars => items;

  void addChar(Char char) {
    add(char);
    persist();
  }

  @override
  Char? getById(String id) {
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
    print('CharRepository.persist: сохраняем игроков:');
    for (final c in items) {
      print('id: \'${c.id}\', name: \'${c.name}\'');
    }
    await StorageService.instance.saveList(
      'chars',
      items.map((c) => c.toJson()).toList(),
    );
  }

  /// Загружает список матчей из StorageService и обновляет items
  Future<void> getAll() async {
    final list = await StorageService.instance.loadList('chars');
    clear();
    addAll(list.map((json) => Char.fromJson(json)));

    print('====================================================================================================================');
    print('CharRepository.getAll: сохр��няем игроков:');
    for (final c in items) {
      print('id: \'${c.id}\', name: \'${c.name}\'');
    }
  }
}
