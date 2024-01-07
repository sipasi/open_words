abstract class IReadonlyList<T> {
  const IReadonlyList();

  bool get isEmpty => length == 0;
  bool get isNotEmpty => length > 0;

  int get length;

  T operator [](int index);
}

class ReadonlyList<T> extends IReadonlyList<T> {
  final List<T> _results;

  const ReadonlyList(this._results);

  @override
  int get length => _results.length;

  @override
  T operator [](int index) => _results[index];
}

extension ReadonlyListExtension<T> on List<T> {
  ReadonlyList<T> asReadonly() => ReadonlyList(this);
}
