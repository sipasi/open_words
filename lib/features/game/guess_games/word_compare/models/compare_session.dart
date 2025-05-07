import 'package:open_words/features/game/guess_games/shared/guess_game_session.dart';
import 'package:open_words/features/game/guess_games/word_compare/models/compare_quiz_item.dart';
import 'package:open_words/features/game/shared/quiz/quiz_position.dart';
import 'package:open_words/features/game/shared/quiz/quiz_repository.dart';

final class CompareSession
    extends GuessGameSession<CompareQuizItem, CompareSession> {
  const CompareSession({
    super.position,
    super.repository,
    super.allQuizFinished,
  });

  @override
  CompareSession copyWith({
    QuizPosition? position,
    QuizRepository<CompareQuizItem>? repository,
    bool? allQuizFinished,
  }) {
    return CompareSession(
      position: position ?? this.position,
      repository: repository ?? this.repository,
      allQuizFinished: allQuizFinished ?? this.allQuizFinished,
    );
  }
}
