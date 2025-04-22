import 'package:open_words/core/collection/linq/property_getter.dart';

extension DistinctByExtension<T> on Iterable<T> {
  Iterable<T> distinctBy<U>(PropertyGetter<T, U?> getter) {
    final seen = <U?>{};
    return where((item) => seen.add(getter(item)));
  }
}
