class WordStatistic {
  final String word;

  final int answerCorrect;
  final int answerIncorrect;

  WordStatistic({
    required this.word,
    required this.answerCorrect,
    required this.answerIncorrect,
  });

  const WordStatistic.empty()
    : word = '',
      answerCorrect = 0,
      answerIncorrect = 0;
}
