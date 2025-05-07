import 'package:open_words/features/game/shared/quiz/quiz_item.dart';

class QuizRepository<T extends QuizItem> {
  final List<T> _quizzes;

  int get length => _quizzes.length;

  Iterable<T> get iterable => _quizzes;

  const QuizRepository([this._quizzes = const []]);

  T at(int index) => _quizzes[index];
  T? atOrNull(int index) {
    if (index < 0 || index >= length) {
      return null;
    }

    return _quizzes[index];
  }
}
