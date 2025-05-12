extension MapByExtension<T> on Iterable<T> {
  Map<U, T> mapBy<U>({required U Function(T language) property}) {
    return Map.fromEntries(map((e) => MapEntry(property(e), e)));
  }
}
