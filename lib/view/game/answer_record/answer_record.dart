class AnswerRecord {
  /// Question that user needs to answer
  final String question;

  /// Correct answer to the question
  final String answer;

  /// Answer privided by the user
  final String userAnswer;

  /// Whether the user's answer is correct
  final bool correct;

  bool get notCorrect => correct == false;

  const AnswerRecord({
    required this.question,
    required this.answer,
    required this.userAnswer,
    required this.correct,
  });
}
