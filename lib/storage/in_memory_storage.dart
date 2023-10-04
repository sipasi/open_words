import 'package:open_words/storage/entity_storage_async.dart';

abstract class InMemoryStorage<T> extends EntityStorageAsync<String, T> {
  final Map<String, T> _items = {};

  @override
  Future<void> clear() {
    _items.clear();

    return Future.value();
  }

  @override
  Future<int> count() {
    return Future.value(_items.length);
  }

  @override
  Future<void> delete(String id) {
    _items.remove(id);

    return Future.value();
  }

  @override
  Future<List<T>> getAll() {
    return Future.value(_items.values.toList());
  }

  @override
  Future<T?> getBy(String id) {
    return _items.containsKey(id)
        ? Future.value(_items[id])
        : Future.value(null);
  }

  @override
  Future<void> set(String id, T entity) {
    _items[id] = entity;

    return Future.value();
  }
}
