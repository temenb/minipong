abstract class Repository<T> {
  final List<T> _items = [];

  List<T> get items => List.unmodifiable(_items);

  void add(T item) {
    _items.add(item);
  }

  T? getById(String id) {
    // Должен быть реализован в наследнике, т.к. нет гарантии, что у T есть поле id
    throw UnimplementedError();
  }

  void remove(String id) {
    // Должен быть реализован в наследнике
    throw UnimplementedError();
  }

  void clear() {
    _items.clear();
  }
}

