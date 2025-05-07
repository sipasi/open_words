import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_match_quiz_item.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

final class PairsMatchSession {
  final QuizPosition position;
  final QuizRepository<PairsMatchQuizItem> repository;
  final bool allQuizFinished;

  int get quizCount => repository.length;
  int get quizPairCount => repository.iterable.fold<int>(
    0,
    (value, element) => value + element.length,
  );

  PairsMatchQuizItem get currentQuiz => repository.at(position.index);

  PairsMatchSession({
    required this.position,
    required this.repository,
    required this.allQuizFinished,
  });
  const PairsMatchSession.initial()
    : position = const QuizPosition(),
      repository = const QuizRepository(),
      allQuizFinished = false;
  const PairsMatchSession.start({required this.repository})
    : position = const QuizPosition(),
      allQuizFinished = false;

  PairsMatchSession updateWithNextQuiz() {
    final next = position.next();

    if (next.index == repository.length) {
      return copyWith(allQuizFinished: true);
    }

    return copyWith(position: next);
  }

  PairsMatchSession copyWith({
    QuizPosition? position,
    QuizRepository<PairsMatchQuizItem>? repository,
    bool? allQuizFinished,
  }) {
    return PairsMatchSession(
      position: position ?? this.position,
      repository: repository ?? this.repository,
      allQuizFinished: allQuizFinished ?? this.allQuizFinished,
    );
  }
}
