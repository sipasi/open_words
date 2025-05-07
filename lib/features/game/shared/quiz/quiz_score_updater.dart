import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

class QuizScoreUpdater {
  final QuizCompletionPolicy policy;

  const QuizScoreUpdater(this.policy);
  const QuizScoreUpdater.allowsCorrectOnlyCompletion()
    : policy = QuizCompletionPolicy.correctOnly;
  const QuizScoreUpdater.allowsIncorrectCompletion()
    : policy = QuizCompletionPolicy.anyAttempt;

  QuizScore copyWithAnswer(QuizScore score, bool isCorrect) {
    if (isCorrect) {
      return _handleCorrectAnswer(score);
    }
    return _handleIncorrectAnswer(score);
  }

  QuizScore _handleCorrectAnswer(QuizScore score) {
    return score.copyWith(
      answeredQuestions: score.questionsAnswered + 1,
      correct: score.correct + 1,
      totalAttempts: score.totalAttempts + 1,
    );
  }

  QuizScore _handleIncorrectAnswer(QuizScore score) {
    final updatedAnsweredQuestions =
        policy.allowsIncorrectCompletion()
            ? score.questionsAnswered + 1
            : score.questionsAnswered;

    return score.copyWith(
      answeredQuestions: updatedAnsweredQuestions,
      wrongAttempts: score.wrongAttempts + 1,
      totalAttempts: score.totalAttempts + 1,
    );
  }
}
