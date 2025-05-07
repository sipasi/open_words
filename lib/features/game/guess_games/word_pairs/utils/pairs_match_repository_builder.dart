import 'package:open_words/core/collection/list_random_extension.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_repository_builder_shared.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_match_quiz_item.dart';
import 'package:open_words/features/game/guess_games/word_pairs/utils/pairs_match_quiz_item_generator.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

final class PairsMatchRepositoryBuilder
    extends GuessGameRepositoryBuilderShared<PairsMatchQuizItem> {
  final int pairsPerQuiz;

  PairsMatchRepositoryBuilder({
    required super.words,
    required super.questionSide,
    required super.quizSize,
    required this.pairsPerQuiz,
  });

  @override
  QuizRepository<PairsMatchQuizItem> build() {
    final generator = PairsMatchQuizItemGenerator(
      shuffledWords: _getShufledWords(),
      quizSize: quizSize,
      questionSide: questionSide,
      pairsPerQuiz: pairsPerQuiz,
    );

    return QuizRepository(generator.generate());
  }

  List<Word> _getShufledWords() => words.toList()..randomize();
}
