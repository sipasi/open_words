import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

abstract class GuessGameRepositoryBuilder<T extends QuizItem> {
  QuizRepository<T> build();
}
