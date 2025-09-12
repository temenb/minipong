import 'package:minipong/entity/game.dart';
import 'package:minipong/services/storage_service.dart';
import 'package:minipong/repositories/repository.dart';

class GameRepository extends Repository<Game> {
  static final GameRepository instance = GameRepository._internal();
  GameRepository._internal();

  List<Game> get games => items;

  void addGame(Game game) {
    add(game);
  }

  @override
  Game? getById(String id) {
    try {
      return items.firstWhere((g) => g.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  void remove(String id) {
    items.removeWhere((g) => g.id == id);
  }

  void clear() => super.clear();

  /// Загружает список игр из StorageService и обновляет items
  Future<void> getAll() async {
    final list = await StorageService.instance.loadList('games');
    items.clear();
    items.addAll(list.map((json) => Game.fromJson(json)));
  }
}
