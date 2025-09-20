import 'package:minipong/entity/character.dart';
import 'package:minipong/repositories/repository.dart';
import 'package:minipong/services/app_logger.dart';
import 'package:minipong/services/storage_service.dart';

class CharacterRepository extends Repository<Character> {
  static final CharacterRepository instance = CharacterRepository._internal();
  CharacterRepository._internal();

  List<Character> get characters => items;

}
