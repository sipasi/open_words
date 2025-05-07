import 'package:open_words/features/game/guess_games/shared/guess_game_repository_builder.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_session_builder_shared.dart';
import 'package:open_words/features/game/guess_games/word_compare/models/compare_quiz_item.dart';
import 'package:open_words/features/game/guess_games/word_compare/models/compare_session.dart';
import 'package:open_words/features/game/guess_games/word_compare/utils/compare_repository_builder.dart';

final class CompareSessionBuilder
    extends GuessGameSessionBuilderShared<CompareSession, CompareQuizItem> {
  const CompareSessionBuilder({
    required super.words,
    required super.quizSize,
    required super.questionSide,
  });

  @override
  GuessGameRepositoryBuilder<CompareQuizItem> get repositoryBuilder {
    return CompareRepositoryBuilder(
      words: words,
      quizSize: quizSize,
      questionSide: questionSide,
    );
  }

  @override
  CompareSession buildSession() {
    return CompareSession(repository: repositoryBuilder.build());
  }
}
