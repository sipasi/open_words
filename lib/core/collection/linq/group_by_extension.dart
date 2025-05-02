import 'package:open_words/core/collection/linq/property_getter.dart';

extension GroupByExtension<T> on Iterable<T> {
  num sumBy(PropertyGetter<T, num> selector) {
    num sum = 0;

    for (var element in this) {
      sum += selector(element);
    }

    return sum;
  }

  Map<Key, List<T>> groupBy<Key>(PropertyGetter<T, Key> ketSelector) {
    var map = <Key, List<T>>{};

    for (var element in this) {
      final key = ketSelector(element);

      (map[key] ??= []).add(element);
    }

    return map;
  }
}
