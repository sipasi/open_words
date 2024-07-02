extension LinqIterable<T> on Iterable<T> {
  num sumBy(num Function(T element) selector) {
    num sum = 0;

    for (var element in this) {
      sum += selector(element);
    }

    return sum;
  }
}
