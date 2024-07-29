enum QuizType {
  compare,
  wordPair,
  audioPair,
  constuctor,
}

abstract class QuizItem {
  bool get allSolved;
  bool get notAllSolved => allSolved == false;

  void clear();
}

class QuizPack {
  final List<QuizItem> _quizzes;

  int get length => _quizzes.length;

  QuizPack(this._quizzes);

  QuizItem at(int index) => _quizzes[index];

  void clear() {
    for (var element in _quizzes) {
      element.clear();
    }
  }
}
