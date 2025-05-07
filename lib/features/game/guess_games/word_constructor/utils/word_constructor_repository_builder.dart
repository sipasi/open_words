import 'package:open_words/features/game/guess_games/shared/guess_game_repository_builder_shared.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_constructor_quiz_item.dart';
import 'package:open_words/features/game/guess_games/word_constructor/utils/word_constructor_quiz_item_generator.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

final class WordConstructorRepositoryBuilder
    extends GuessGameRepositoryBuilderShared<WordConstructorQuizItem> {
  WordConstructorRepositoryBuilder({
    required super.words,
    required super.quizSize,
    required super.questionSide,
  });

  @override
  QuizRepository<WordConstructorQuizItem> build() {
    final generator = WordConstructorQuizItemGenerator(
      words: words,
      questionSide: questionSide,
      quizSize: quizSize,
    );

    return QuizRepository(generator.generate());
  }
}
