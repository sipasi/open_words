import 'package:open_words/storage/entity_storage_async.dart';
import 'package:sembast/sembast.dart';

abstract class SembastBaseStorage<T> extends EntityStorageAsync<int, T> {
  static const idName = 'id';

  final Database database;
  final StoreRef<int, Map<String, Object?>> store;

  SembastBaseStorage({required this.database, required String name}) : store = intMapStoreFactory.store(name);

  @override
  Future<void> clear() {
    return store.delete(database);
  }

  @override
  Future<int> count() {
    return store.count(database);
  }

  @override
  Future<void> delete(int id) {
    return store.record(id).delete(database);
  }

  @override
  Future<List<T>> getAll() async {
    final all = await store.find(database);

    if (all.isEmpty) {
      return List.empty(growable: true);
    }

    return all.map((map) => fromJson(map.value)).toList();
  }

  @override
  Future<T?> getBy(int id) async {
    final map = await store.record(id).get(database);

    return map == null ? null : fromJson(map);
  }

  @override
  Future<T> updateOrCreate(T entity) async {
    final map = await _updateOrCreate(entity);

    return fromJson(map);
  }

  Future<Map<String, dynamic>> _updateOrCreate(T entity) async {
    final map = toJson(entity);

    int? id = getId(entity);

    if (id is int) {
      await store.record(id).put(database, map);
    } else {
      id = await store.add(database, map);

      map[idName] = id;

      await store.record(id).update(database, {'id': id});
    }

    return map;
  }

  @override
  Future<bool> contains(int id) {
    return store.record(id).exists(database);
  }

  @override
  Future dispose() {
    return database.close();
  }

  int? getId(T entity);

  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T entity);
}
