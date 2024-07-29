abstract class ReadonlyScore {
  int get total;
  int get answered;
  int get correct;
  int get wrong;

  double get progressPercentage => answered / total;
}

class GuessScore extends ReadonlyScore {
  final int _total;
  int _answered = 0;
  int _correct = 0;
  int _wrong = 0;

  @override
  int get total => _total;
  @override
  int get answered => _answered;
  @override
  int get correct => _correct;
  @override
  int get wrong => _wrong;

  GuessScore(this._total);

  void answerCorrect() {
    _answered++;
    _correct++;
  }

  void answerWrong() {
    _answered++;
    _wrong++;
  }

  void answer(bool correct) => correct ? answerCorrect() : answerWrong();

  void clear() {
    _answered = _correct = _wrong = 0;
  }
}
