class Ref<T> {
  T? _ref;

  T? get value => _ref;

  void set(T? metadata) {
    _ref = metadata;
  }
}
