import 'match_manager.dart';
import '../entity/game.dart';

class GameManager {
  late Game _game;
  final List<MatchManager> _matches = [];

  GameManager({required List<String> characterIds}) {
    _game = Game(characterIds: characterIds, createdAt: DateTime.now());
  }

  Game get game => _game;
  List<MatchManager> get matches => _matches;

  MatchManager createMatch() {
    final matchManager = MatchManager();
    _matches.add(matchManager);
    return matchManager;
  }
}
