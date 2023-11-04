import 'dart:math';
import 'package:open_words/data/word/word.dart';

extension WordListRandomExtension on List<Word> {
  static final Random _random = Random();

  List<Word> getRandom({required int count, Word? exclude}) {
    final randoms = <Word>[];

    if (count >= length) {
      return List.empty();
    }

    if (exclude != null) {
      randoms.add(exclude);
    }

    int repeat = 0;

    while (randoms.length != count) {
      int index = _random.nextInt(length);

      Word word = this[index];

      if (repeat++ == 500) {
        break;
      }

      if (randoms.contains(word)) {
        continue;
      }

      randoms.add(word);
    }

    return randoms..shuffle();
  }
}
