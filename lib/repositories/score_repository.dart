import 'package:minipong/entity/score.dart';
import 'package:minipong/repositories/repository.dart';

class ScoreRepository extends Repository<Score> {
  static final ScoreRepository instance = ScoreRepository._internal();
  ScoreRepository._internal();

  List<Score> get scores => items;

  void addScore(Score score) => add(score);

  @override
  Score? getById(String id) {
    try {
      return items.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  void remove(String id) {
    items.removeWhere((s) => s.id == id);
  }

  void clear() => super.clear();
}

