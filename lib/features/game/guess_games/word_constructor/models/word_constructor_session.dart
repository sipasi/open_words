import 'package:open_words/features/game/guess_games/word_constructor/models/word_constructor_quiz_item.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

class WordConstructorSession {
  final QuizPosition position;
  final QuizRepository<WordConstructorQuizItem> repository;
  final bool allQuizFinished;

  int get quizCount => repository.length;

  WordConstructorQuizItem get currentQuiz => repository.at(position.index);

  WordConstructorSession({
    required this.position,
    required this.repository,
    required this.allQuizFinished,
  });
  const WordConstructorSession.initial()
    : position = const QuizPosition(),
      repository = const QuizRepository(),
      allQuizFinished = false;
  const WordConstructorSession.start({required this.repository})
    : position = const QuizPosition(),
      allQuizFinished = false;

  WordConstructorSession copyWithNextQuiz() {
    final next = position.next();

    if (next.index == repository.length) {
      return copyWith(allQuizFinished: true);
    }

    return copyWith(position: next);
  }

  WordConstructorSession copyWith({
    QuizPosition? position,
    QuizRepository<WordConstructorQuizItem>? repository,
    bool? allQuizFinished,
  }) {
    return WordConstructorSession(
      position: position ?? this.position,
      repository: repository ?? this.repository,
      allQuizFinished: allQuizFinished ?? this.allQuizFinished,
    );
  }
}
