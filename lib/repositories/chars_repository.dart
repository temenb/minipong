import 'package:minipong/entity/char.dart';

class CharRepository {
  static final CharRepository instance = CharRepository._internal();
  CharRepository._internal();

  final List<Char> _chars = [];

  List<Char> get chars => List.unmodifiable(_chars);
}
