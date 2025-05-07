import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/shared/quiz/quiz_question_side.dart';

sealed class QuizValidator {
  static const QuizValidator byVariantSide = ByVariantSideValidator._();

  const QuizValidator();

  bool validateWords({
    required QuizQuestionSide side,
    required Word question,
    required Word answer,
  });
  bool validateTexts({
    required String correctAnswer,
    required String userAnswer,
  });
}

final class ByVariantSideValidator extends QuizValidator {
  const ByVariantSideValidator._();

  @override
  bool validateWords({
    required QuizQuestionSide side,
    required Word question,
    required Word answer,
  }) {
    return validateTexts(
      correctAnswer: side.variant(question),
      userAnswer: side.variant(answer),
    );
  }

  @override
  bool validateTexts({
    required String correctAnswer,
    required String userAnswer,
  }) {
    return correctAnswer == userAnswer;
  }
}
