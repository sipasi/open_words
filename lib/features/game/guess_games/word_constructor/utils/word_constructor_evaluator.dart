final class WordConstructorEvaluator {
  const WordConstructorEvaluator();

  bool isCorrectAnswer({
    required String correctAnswer,
    required String userAnswer,
  }) {
    return correctAnswer == userAnswer;
  }
}
