abstract class IReadonlyList<T> with Iterable<T> {
  const IReadonlyList();

  T operator [](int index);
}

class ReadonlyList<T> extends IReadonlyList<T> {
  final List<T> _results;

  const ReadonlyList(this._results);

  @override
  int get length => _results.length;

  @override
  T operator [](int index) => _results[index];

  @override
  Iterator<T> get iterator => _results.iterator;
}

extension ReadonlyListExtension<T> on List<T> {
  ReadonlyList<T> asReadonly() => ReadonlyList(this);
}
