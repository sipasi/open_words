import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_repository_builder.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

abstract class GuessGameRepositoryBuilderShared<T extends QuizItem>
    extends GuessGameRepositoryBuilder<T> {
  final List<Word> words;
  final QuizSize quizSize;
  final QuizQuestionSide questionSide;

  GuessGameRepositoryBuilderShared({
    required this.words,
    required this.quizSize,
    required this.questionSide,
  });
}
