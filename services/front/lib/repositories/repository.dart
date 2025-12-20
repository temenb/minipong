import 'package:flutter/foundation.dart';

abstract class Repository<T> {
  final List<T> _items = [];

  List<T> get items => List.unmodifiable(_items);
  void add(T item) {
    _items.add(item);
  }

  void addAll(Iterable<T> items) {
    _items.addAll(items);
  }

  /// Защищённый метод удаления по id
  @protected
  /// Удаляет персонажа по индексу
  void remove(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    }
  }

  void clear() {
    _items.clear();
  }
}
