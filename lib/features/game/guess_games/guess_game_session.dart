import 'package:flutter/foundation.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

abstract class GuessGameSession<
  TQuizItem extends QuizItem,
  TSession extends GuessGameSession<TQuizItem, TSession>
> {
  final QuizPosition position;
  final QuizRepository<TQuizItem> repository;
  final bool allQuizFinished;

  int get quizCount => repository.length;

  bool get isEmpty => repository.length == 0;

  TQuizItem? get beforeQuiz => repository.atOrNull(position.index - 1);
  TQuizItem get currentQuiz => repository.at(position.index);

  const GuessGameSession({
    this.position = const QuizPosition(),
    this.repository = const QuizRepository(),
    this.allQuizFinished = false,
  });

  @nonVirtual
  TSession copyWithNextQuiz() {
    final next = position.next();

    if (next.index == repository.length) {
      return copyWith(allQuizFinished: true);
    }

    return copyWith(position: next);
  }

  TSession copyWith({
    QuizPosition? position,
    QuizRepository<TQuizItem>? repository,
    bool? allQuizFinished,
  });
}
