class QuizScore {
  /// Correctly answered
  final int correct;

  /// Incorrectly answered
  final int wrongAttempts;

  /// Total number of questions in the quiz
  final int totalQuestions;

  /// Total number of questions that the user has answered
  final int questionsAnswered;

  /// Total number of answer attempts (both correct and incorrect)
  final int totalAttempts;

  /// Checks if there are no answer attempts
  bool get hasNoAttempts => totalAttempts == 0;

  /// Checks if there are no answer questions
  bool get hasNoQuestions => totalQuestions == 0;

  /// Score percentage (correct / totalAttempts), e.g. 0.8 = 80%
  double get correctAccuracy => hasNoAttempts ? 0 : correct / totalAttempts;

  /// Progress percentage (questionsAnswered / totalQuestions), e.g. 0.6 = 60%
  double get progress =>
      hasNoQuestions ? 0 : questionsAnswered / totalQuestions;

  /// Checks if the quiz is complete (answered all questions)
  bool get isComplete => questionsAnswered >= totalQuestions;

  const QuizScore({
    required this.correct,
    required this.wrongAttempts,
    required this.totalAttempts,
    required this.totalQuestions,
    required this.questionsAnswered,
  });
  const QuizScore.initial()
    : correct = 0,
      wrongAttempts = 0,
      totalAttempts = 0,
      totalQuestions = 0,
      questionsAnswered = 0;
  const QuizScore.start({required this.totalQuestions})
    : correct = 0,
      wrongAttempts = 0,
      totalAttempts = 0,
      questionsAnswered = 0;

  QuizScore copyWith({
    int? correct,
    int? wrongAttempts,
    int? totalAttempts,
    int? totalQuestions,
    int? answeredQuestions,
  }) {
    return QuizScore(
      correct: correct ?? this.correct,
      totalAttempts: totalAttempts ?? this.totalAttempts,
      wrongAttempts: wrongAttempts ?? this.wrongAttempts,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      questionsAnswered: answeredQuestions ?? questionsAnswered,
    );
  }
}
