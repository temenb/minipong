import 'package:minipong/entity/game.dart';
import 'package:minipong/services/storage_service.dart';
import 'package:minipong/repositories/repository.dart';

class GameRepository extends Repository<Game> {
  static final GameRepository instance = GameRepository._internal();
  GameRepository._internal();

  List<Game> get games => items;

}
