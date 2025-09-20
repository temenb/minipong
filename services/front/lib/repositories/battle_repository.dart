import 'package:minipong/entity/battle.dart';
import 'package:minipong/repositories/repository.dart';

class BattleRepository extends Repository<Battle> {
  static final BattleRepository instance = BattleRepository._internal();
  BattleRepository._internal();

  List<Battle> get battles => items;

}
