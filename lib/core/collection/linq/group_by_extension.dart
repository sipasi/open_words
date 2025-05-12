import 'package:open_words/core/collection/linq/property_getter.dart';

extension GroupByExtension<T> on Iterable<T> {
  num sumBy(PropertyGetter<T, num> selector) {
    num sum = 0;

    for (var element in this) {
      sum += selector(element);
    }

    return sum;
  }

  Map<Key, List<T>> groupBy<Key>(PropertyGetter<T, Key> keySelector) {
    var map = <Key, List<T>>{};

    for (var element in this) {
      final key = keySelector(element);

      (map[key] ??= []).add(element);
    }

    return map;
  }
}
