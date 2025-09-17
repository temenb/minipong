import 'battle_manager.dart';
import '../entity/match.dart';

class MatchManager {
  late Match _match;
  final List<BattleManager> _battles = [];

  MatchManager() {
    _match = Match(battleIds: [], createdAt: DateTime.now());
  }

  Match get match => _match;
  List<BattleManager> get battles => _battles;

  BattleManager startBattle(List<String> characterNames) {
    final battleManager = BattleManager(characterNames: characterNames);
    _battles.add(battleManager);
    return battleManager;
  }
}
