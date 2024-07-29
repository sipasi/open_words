import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/guess_game/match_pairs/pair_part.dart';
import 'package:open_words/view/game/guess_game/word_question_side.dart';

import 'pair_quiz_item.dart';

class PairsSelector {
  PairPart? _question;
  PairPart? _variant;

  final bool canDeselect;

  final WordQuestionSide questionSide;

  PairPart? get question => _question;
  PairPart? get variant => _variant;

  String? get questionText => getText(question, questionSide.question);
  String? get correctVariantText => getText(question, questionSide.variant);
  String? get userVariantText => getText(variant, questionSide.variant);

  bool get questionSelected => _question != null;
  bool get variantSelected => _variant != null;
  bool get bothSelected => questionSelected && variantSelected;
  bool get bothCorrectSelected => sameSelected();

  PairsSelector({
    required this.questionSide,
    this.canDeselect = true,
  });

  void selectQuestion(PairQuizItem quiz, int selected) => _onSlelect(
        current: _question,
        next: quiz.questionAt(selected),
        set: (next) => _question = next,
      );

  void selectVariant(PairQuizItem quiz, int selected) => _onSlelect(
        current: _variant,
        next: quiz.variantAt(selected),
        set: (next) => _variant = next,
      );

  void _onSlelect({
    required PairPart? current,
    required PairPart next,
    required void Function(PairPart?) set,
  }) {
    if (next != current) {
      set(next);
      current?.unselect();
      next.select();
      return;
    }

    if (canDeselect == false) {
      return;
    }

    current?.unselect();

    set(null);
  }

  void handleIfBothSelected(PairQuizItem quiz) {
    if (bothSelected == false) {
      return;
    }

    question?.unselect();
    variant?.unselect();

    _question = null;
    _variant = null;
  }

  bool sameSelected() {
    if (variant == null || question == null) {
      return false;
    }

    return questionSide.variant(question!.word) == questionSide.variant(variant!.word);
  }

  static String? getText(PairPart? part, String Function(Word word) side) {
    return part != null ? side(part.word) : null;
  }
}
