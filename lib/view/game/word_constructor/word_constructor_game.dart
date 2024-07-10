import 'package:open_words/collection/linq_iterable.dart';
import 'package:open_words/collection/list_randomizer.dart';
import 'package:open_words/data/word/word.dart';

import 'word_constructor_state.dart';

class WordConstructorGame {
  final List<WordConstructorState> _states;

  int _index;

  WordConstructorState get current => _states[_index];

  double get constructedPercentage => _states.sumBy((element) => element.constructed ? 1 : 0) / _states.length;

  bool get lastState => _index + 1 == _states.length;

  bool get canNext => current.constructed && lastState == false;

  bool get canInteract => current.constructed == false;

  final void Function() onCorrectConstructed;
  final void Function() onWrongConstructed;
  final void Function() onGameEnd;

  factory WordConstructorGame({
    required List<Word> words,
    required void Function() onCorrectConstructed,
    required void Function() onWrongConstructed,
    required void Function() onGameEnd,
  }) {
    List<WordConstructorState> states = List.generate(
      words.length,
      (index) {
        return WordConstructorState.byTwoLetter(words[index]);
      },
    );

    states.randomize(times: 5);

    return WordConstructorGame._(
      states,
      onCorrectConstructed,
      onWrongConstructed,
      onGameEnd,
    );
  }

  WordConstructorGame._(
    this._states,
    this.onCorrectConstructed,
    this.onWrongConstructed,
    this.onGameEnd,
  ) : _index = 0;

  void onAnswerTap(int id) => _onTap(() => current.onAnswerTap(id));

  void onVariantTap(int id) => _onTap(() => current.onVariantTap(id));

  void next() {
    _index = (_index + 1) % _states.length;
  }

  void _onTap(void Function() tapHandler) {
    if (canInteract == false) {
      return;
    }

    tapHandler();

    if (current.constructed == false) {
      return;
    }

    final action = current.matched ? onCorrectConstructed : onWrongConstructed;

    action();

    if (lastState) {
      onGameEnd();
    }
  }
}
