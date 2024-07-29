import 'package:open_words/data/word/word.dart';

class PairPart {
  bool _solved;
  bool _selected;

  final Word word;
  final String text;

  bool get solved => _solved;
  bool get selected => _selected;

  PairPart(this.word, this.text)
      : _solved = false,
        _selected = false;

  PairPart.origin(Word word) : this(word, word.origin);
  PairPart.translation(Word word) : this(word, word.translation);

  void markAsSolved() => _solved = true;
  void select() => _selected = true;
  void unselect() => _selected = false;

  bool sameTranslation(PairPart? other) {
    if (other == null) {
      return false;
    }

    return word.translation == other.word.translation;
  }

  void clear() => _selected = _solved = false;
}
