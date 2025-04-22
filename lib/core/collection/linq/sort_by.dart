import 'package:open_words/core/collection/linq/property_getter.dart';

extension SortList<T extends Comparable<T>> on List<T> {
  void sortAsc() {
    sort((a, b) => a.compareTo(b));
  }

  void sortDesc() {
    sort((a, b) => b.compareTo(a));
  }
}

extension SortListBy<T> on List<T> {
  void sortAscBy<U extends Comparable<U>>(PropertyGetter<T, U> getter) {
    sort((a, b) => getter(a).compareTo(getter(b)));
  }

  void sortDescBy<U extends Comparable<U>>(PropertyGetter<T, U> getter) {
    sort((a, b) => getter(b).compareTo(getter(a)));
  }
}
