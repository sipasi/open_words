class TimeMeasureResult {
  final String value;
  final Duration elapsed;

  String get valueString => value.toString();
  String get elapsedString => elapsed.toString().substring(5);

  const TimeMeasureResult(this.value, this.elapsed);
  const TimeMeasureResult.empty() : value = '', elapsed = const Duration();
}

class TimeMeasureInfo<T> {
  TimeMeasureResult _average = const TimeMeasureResult.empty();

  final List<TimeMeasureResult> _results = [];

  final String name;
  final Future Function() future;

  int get measureTimes => _results.length;

  TimeMeasureResult get last =>
      _results.isEmpty ? TimeMeasureResult.empty() : _results.last;

  TimeMeasureResult get average => _average;

  TimeMeasureInfo(this.name, this.future);

  Future measure([int times = 1]) async {
    final stopwatch = Stopwatch();

    for (var i = 0; i < times; i++) {
      stopwatch.start();

      final value = await future();

      stopwatch.stop();

      final text =
          value == null
              ? 'null'
              : value is int
              ? value.toString()
              : 'not int';

      _results.add(TimeMeasureResult(text, stopwatch.elapsed));

      stopwatch.reset();
    }

    _average = _clacAverage();
  }

  TimeMeasureResult _clacAverage() {
    if (_results.isEmpty) return const TimeMeasureResult.empty();

    final total = _results.fold<Duration>(
      Duration.zero,
      (sum, duration) => sum + duration.elapsed,
    );

    return TimeMeasureResult(last.value, total ~/ _results.length);
  }
}
