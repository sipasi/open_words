typedef Predicate<T> = bool Function(T entity);

abstract class EntityStorageAsync<TKey, TEntity> {
  Future<int> count();

  Future<bool> contains(TKey id);

  Future<TEntity?> getBy(TKey id);

  Future<List<TEntity>> getAll();

  Future<TEntity> updateOrCreate(TEntity entity);

  Future delete(TKey id);

  Future clear();
  Future dispose();
}
