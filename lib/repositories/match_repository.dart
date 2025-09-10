import 'package:minipong/entity/match.dart';
import 'package:minipong/repositories/repository.dart';

class MatchRepository extends Repository<Match> {
  static final MatchRepository instance = MatchRepository._internal();
  MatchRepository._internal();

  List<Match> get matches => items;

  void addMatch(Match match) => add(match);

  @override
  Match? getById(String id) {
    try {
      return items.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  void remove(String id) {
    items.removeWhere((m) => m.id == id);
  }

  void clear() => super.clear();
}

