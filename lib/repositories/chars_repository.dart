import 'package:minipong/entity/char.dart';
import 'package:minipong/repositories/repository.dart';

class CharRepository extends Repository<Char> {
  static final CharRepository instance = CharRepository._internal();
  CharRepository._internal();

  List<Char> get chars => items;

  void addChar(Char char) => add(char);

  @override
  Char? getById(String id) {
    try {
      return items.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  void remove(String id) {
    items.removeWhere((c) => c.id == id);
  }

  void clear() => super.clear();
}
