import 'package:open_words/data/word/word.dart';

import 'pair_data.dart';
import 'pair_state.dart';

class PairPart {
  final PairData _data;
  final PairState _state = PairState();

  String get text => _data.text;

  bool get answered => _state.answered;
  bool get selected => _state.selected;

  PairPart.origin(Word word) : _data = PairData.origin(word);
  PairPart.translation(Word word) : _data = PairData.translation(word);

  void answer() => _state.answer();
  void select() => _state.select();
  void unselect() => _state.unselect();

  bool sameWord(PairPart? other) {
    if (other == null) {
      return false;
    }

    return _data.word == other._data.word;
  }
}
