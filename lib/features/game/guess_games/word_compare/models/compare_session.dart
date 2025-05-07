import 'package:open_words/features/game/guess_games/word_compare/models/compare_quiz_item.dart';
import 'package:open_words/features/game/shared/quiz/quiz_position.dart';
import 'package:open_words/features/game/shared/quiz/quiz_repository.dart';

class CompareSession {
  final QuizPosition position;
  final QuizRepository<CompareQuizItem> repository;
  final bool allQuizFinished;

  int get quizCount => repository.length;

  CompareQuizItem? get beforeQuiz => repository.atOrNull(position.index - 1);
  CompareQuizItem get currentQuiz => repository.at(position.index);

  CompareSession({
    required this.position,
    required this.repository,
    required this.allQuizFinished,
  });
  const CompareSession.initial()
    : position = const QuizPosition(),
      repository = const QuizRepository(),
      allQuizFinished = false;
  const CompareSession.start({required this.repository})
    : position = const QuizPosition(),
      allQuizFinished = false;

  CompareSession updateWithNextQuiz() {
    final next = position.next();

    if (next.index == repository.length) {
      return copyWith(allQuizFinidhed: true);
    }

    return copyWith(quizPosition: next);
  }

  CompareSession copyWith({
    QuizPosition? quizPosition,
    QuizRepository<CompareQuizItem>? quizRepository,
    bool? allQuizFinidhed,
  }) {
    return CompareSession(
      position: quizPosition ?? position,
      repository: quizRepository ?? repository,
      allQuizFinished: allQuizFinidhed ?? allQuizFinished,
    );
  }
}
