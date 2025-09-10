import 'package:minipong/entity/battle.dart';
import 'package:minipong/repositories/repository.dart';

class BattleRepository extends Repository<Battle> {
  static final BattleRepository instance = BattleRepository._internal();
  BattleRepository._internal();

  List<Battle> get battles => items;

  void addBattle(Battle battle) => add(battle);

  @override
  Battle? getById(String id) {
    try {
      return items.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  void remove(String id) {
    items.removeWhere((b) => b.id == id);
  }

  void clear() => super.clear();
}
