abstract class EntityStorageAsync<TKey, TEntity> {
  Future<int> count();

  Future<TEntity?> getBy(TKey id);

  Future<List<TEntity>> getAll();

  Future<void> set(TKey id, TEntity entity);
  Future<void> delete(TKey id);

  Future<void> clear();
}
