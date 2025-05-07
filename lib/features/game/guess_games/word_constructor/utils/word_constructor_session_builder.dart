import 'package:open_words/features/game/guess_games/shared/guess_game_repository_builder.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_session_builder_shared.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_constructor_quiz_item.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_constructor_session.dart';
import 'package:open_words/features/game/guess_games/word_constructor/utils/word_constructor_repository_builder.dart';

class WordConstructorSessionBuilder
    extends
        GuessGameSessionBuilderShared<
          WordConstructorSession,
          WordConstructorQuizItem
        > {
  WordConstructorSessionBuilder({
    required super.words,
    required super.quizSize,
    required super.questionSide,
  });

  @override
  GuessGameRepositoryBuilder<WordConstructorQuizItem> get repositoryBuilder {
    return WordConstructorRepositoryBuilder(
      words: words,
      quizSize: quizSize,
      questionSide: questionSide,
    );
  }

  @override
  WordConstructorSession buildSession() {
    return WordConstructorSession(repository: repositoryBuilder.build());
  }
}
