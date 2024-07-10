extension ListRandomizer<T> on List<T> {
  void randomize({int times = 1}) {
    for (var i = 0; i < times; i++) {
      shuffle();
    }
  }
}
