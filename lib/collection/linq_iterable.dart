extension LinqIterable<T> on Iterable<T> {
  num sumBy(num Function(T element) selector) {
    num sum = 0;

    for (var element in this) {
      sum += selector(element);
    }

    return sum;
  }
}

extension LinqNumIterable<T> on Iterable<num> {
  T sum() {
    return sumBy((element) => element) as T;
  }
}
