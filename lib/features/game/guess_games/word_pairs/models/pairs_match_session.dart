import 'package:open_words/features/game/guess_games/guess_game_session.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_match_quiz_item.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

final class PairsMatchSession
    extends GuessGameSession<PairsMatchQuizItem, PairsMatchSession> {
  int get quizPairCount => repository.iterable.fold<int>(
    0,
    (value, element) => value + element.length,
  );

  const PairsMatchSession({
    super.position,
    super.repository,
    super.allQuizFinished,
  });

  @override
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
