import 'package:open_words/collection/list_randomizer.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/word_game.dart';

class FlashcardGame extends WordGame {
  final List<Word> _words;
  final CardSideFiller _filler;

  int get allWords => _words.length;

  Word get current => _words[position];

  String get face => _filler.face(current);
  String get back => _filler.back(current);

  @override
  bool get last => position + 1 == allWords;

  @override
  bool get canPrev => position > 0;
  @override
  bool get canNext => position < _words.length;

  FlashcardGame({
    required super.onGameEnd,
    required List<Word> words,
    required CardSideFiller filler,
  })  : _words = words,
        _filler = filler;

  @override
  void init() {
    _words.randomize(times: 15);
  }

  @override
  void restart() {
    super.restart();

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
