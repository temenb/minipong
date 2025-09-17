import 'package:minipong/entity/score.dart';
import 'package:minipong/repositories/repository.dart';

class ScoreRepository extends Repository<Score> {
  static final ScoreRepository instance = ScoreRepository._internal();
  ScoreRepository._internal();

  List<Score> get scores => items;

}

