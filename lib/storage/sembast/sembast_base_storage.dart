import 'package:open_words/storage/entity_storage_async.dart';
import 'package:sembast/sembast.dart';

abstract class SembastBaseStorage<T> extends EntityStorageAsync<String, T> {
  final Database _database;
  final StoreRef<String, Map<String, Object?>> _store;

  SembastBaseStorage({required Database database, required String name})
      : _database = database,
        _store = stringMapStoreFactory.store(name);

  @override
  Future<void> clear() {
    return _store.delete(_database);
  }

  @override
  Future<int> count() {
    return _store.count(_database);
  }

  @override
  Future<void> delete(String id) {
    return _store.record(id).delete(_database);
  }

  @override
  Future<List<T>> getAll() async {
    final all = await _store.find(_database, finder: getAllFinder());

    if (all.isEmpty) {
      return List.empty();
    }

    return all.map((map) => fromJson(map.value)).toList();
  }

  @override
  Future<T?> getBy(String id) async {
    final map = await _store.record(id).get(_database);

    return map == null ? null : fromJson(map);
  }

  @override
  Future<void> set(String id, T entity) {
    final map = toJson(entity);

    return _store.record(id).put(_database, map);
  }

  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T entity);

  Finder? getAllFinder() => null;
}
