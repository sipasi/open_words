import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/guess_game/word_question_side.dart';

abstract class SolveValidator {
  static const SolveValidator byVariantSide = ByVariantSideValidator();

  const SolveValidator();

  bool validateWords({required WordQuestionSide side, required Word question, required Word answer});
  bool validateTexts({required String correctAnswer, required String userAnswer});
}

class ByVariantSideValidator extends SolveValidator {
  const ByVariantSideValidator();

  @override
  bool validateWords({required WordQuestionSide side, required Word question, required Word answer}) {
    return validateTexts(correctAnswer: side.variant(question), userAnswer: side.variant(answer));
  }

  @override
  bool validateTexts({required String correctAnswer, required String userAnswer}) {
    return correctAnswer == userAnswer;
  }
}
