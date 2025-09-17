import 'package:minipong/entity/match.dart';
import 'package:minipong/repositories/repository.dart';
import 'package:minipong/services/storage_service.dart';

class MatchRepository extends Repository<Match> {
  static final MatchRepository instance = MatchRepository._internal();
  MatchRepository._internal();

  List<Match> get matches => items;

}
