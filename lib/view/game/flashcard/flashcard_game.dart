import 'package:open_words/collection/list_randomizer.dart';
import 'package:open_words/data/word/word.dart';

class FlashcardGame {
  final List<Word> _words;
  final CardSideFiller _filler;

  final void Function() _onGameEnd;

  int _index;
  bool _gameEnd;

  bool get canPrev => _index > 0;
  bool get canNext => _index < _words.length;
  bool get last => _index + 1 == _words.length;

  double get progressPercentage => (_index + (_gameEnd ? 1 : 0)) / _words.length;

  Word get current => _words[_index];

  String get face => _filler.face(current);
  String get back => _filler.back(current);

  FlashcardGame({
    required List<Word> words,
    required CardSideFiller filler,
    required void Function() onGameEnd,
  })  : _words = words,
        _filler = filler,
        _onGameEnd = onGameEnd,
        _index = 0,
        _gameEnd = false;

  void prev() {
    if (_gameEnd) {
      return;
    }

    if (canPrev) _index--;
  }

  void next() {
    if (_gameEnd) {
      return;
    }

    if (last) {
      _gameEnd = true;
      _onGameEnd();
      return;
    }

    if (canNext) _index++;
  }

  void restart() {
    _index = 0;
    _gameEnd = false;

    _words.randomize(times: 15);
  }
}

class CardSideFiller {
  final String Function(Word word) face;
  final String Function(Word word) back;

  const CardSideFiller.origin()
      : face = _origin,
        back = _translation;
  const CardSideFiller.translation()
      : face = _translation,
        back = _origin;

  static String _origin(Word word) => word.origin;
  static String _translation(Word word) => word.translation;
}
