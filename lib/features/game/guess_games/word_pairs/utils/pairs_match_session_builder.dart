import 'package:open_words/features/game/guess_games/shared/guess_game_repository_builder.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_session_builder_shared.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_match_quiz_item.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_match_session.dart';
import 'package:open_words/features/game/guess_games/word_pairs/utils/pairs_match_repository_builder.dart';

final class PairsMatchSessionBuilder
    extends
        GuessGameSessionBuilderShared<PairsMatchSession, PairsMatchQuizItem> {
  PairsMatchSessionBuilder({
    required super.words,
    required super.quizSize,
    required super.questionSide,
  });

  @override
  GuessGameRepositoryBuilder<PairsMatchQuizItem> get repositoryBuilder {
    return PairsMatchRepositoryBuilder(
      words: words,
      questionSide: questionSide,
      quizSize: quizSize,
      pairsPerQuiz: 5,
    );
  }

  @override
  PairsMatchSession buildSession() {
    return PairsMatchSession(repository: repositoryBuilder.build());
  }
}
