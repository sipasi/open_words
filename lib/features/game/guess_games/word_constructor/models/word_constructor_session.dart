import 'package:open_words/features/game/guess_games/guess_game_session.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_constructor_quiz_item.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

final class WordConstructorSession
    extends GuessGameSession<WordConstructorQuizItem, WordConstructorSession> {
  const WordConstructorSession({
    super.position,
    super.repository,
    super.allQuizFinished,
  });

  @override
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
