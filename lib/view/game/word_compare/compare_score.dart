class CompareScore {
  final int _total;
  int _answered = 0;
  int _correct = 0;
  int _wrong = 0;

  int get total => _total;
  int get answered => _answered;
  int get correct => _correct;
  int get wrong => _wrong;

  CompareScore(this._total);

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
