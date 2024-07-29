import 'dart:math';
import 'package:open_words/collection/list_randomizer.dart';

extension ListRandomExtension<T> on List<T> {
  static final Random _random = Random();

  List<T> getRandom({required int count, T? exclude}) {
    final randoms = <T>[];

    if (count >= length) {
      return List.empty();
    }

    if (exclude != null) {
      randoms.add(exclude);
    }

    int repeat = 0;

    while (randoms.length != count) {
      int index = _random.nextInt(length);

      T word = this[index];

      if (repeat++ == 500) {
        break;
      }

      if (randoms.contains(word)) {
        continue;
      }

      randoms.add(word);
    }

    return randoms..randomize();
  }
}
