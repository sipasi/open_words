import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/guess_games/word_compare/models/compare_quiz_item.dart';
import 'package:open_words/features/game/shared/quiz/quiz_validator.dart';

final class CompareAnswerEvaluator {
  const CompareAnswerEvaluator();

  bool isCorrectAnswer({required CompareQuizItem quiz, required Word answer}) {
    return QuizValidator.byVariantSide.validateWords(
      side: quiz.side,
      question: quiz.question,
      answer: answer,
    );
  }
}
