import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/match_pairs/pair_pack.dart';
import 'package:open_words/view/game/match_pairs/pairs_game_state.dart';
import 'package:open_words/view/game/match_pairs/pairs_selector.dart';

class WordPairsGame {
  final PairsGameState _state;
  final PairsSelector _selector;

  double get answeredPairsPercentage => _state.answeredPairsPercentage;

  bool get lastPack => _state.lastPack;

  PairPack get current => _state.current;

  final void Function() onCorrectAnswer;
  final void Function() onWrongAnswer;
  final void Function() onGameEnd;

  WordPairsGame({
    required List<Word> words,
    required this.onCorrectAnswer,
    required this.onWrongAnswer,
    required this.onGameEnd,
  })  : _state = PairsGameState.copyWords(words),
        _selector = PairsSelector(canDeselect: false);

  void selectOrigin(int index) {
    _selector.selectOrigin(current.originAt(index));

    _checkGameOver();
  }

  void selectTranslation(int index) {
    _selector.selectTranslation(current.translationAt(index));

    _checkGameOver();
  }

  void _checkGameOver() {
    if (_state.gameEnd) {
      onGameEnd();
    }
  }

  void tryNextPack() => _state.tryNextPack();
}
