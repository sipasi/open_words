import 'package:open_words/core/collection/list_random_extension.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_repository_builder_shared.dart';
import 'package:open_words/features/game/guess_games/word_compare/models/compare_quiz_item.dart';
import 'package:open_words/features/game/guess_games/word_compare/utils/compare_quiz_item_generator.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

final class CompareRepositoryBuilder
    extends GuessGameRepositoryBuilderShared<CompareQuizItem> {
  CompareRepositoryBuilder({
    required super.words,
    required super.quizSize,
    required super.questionSide,
  });

  @override
  QuizRepository<CompareQuizItem> build() {
    final generator = CompareQuizItemGenerator(
      questionsRange: _selectQuestions(),
      answersPool: words,
      questionSide: questionSide,
      answerCount: 4,
    );

    final quizzes = generator.generate();

    return QuizRepository(quizzes..randomize());
  }

  List<Word> _selectQuestions() {
    return words.getRandom(count: quizSize.preferredSize);
  }
}
