import 'package:open_words/core/collection/list_random_extension.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/guess_games/word_compare/models/compare_quiz_item.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

final class CompareQuizItemGenerator {
  final List<Word> questionsRange;
  final List<Word> answersPool;

  final QuizQuestionSide questionSide;

  final int answerCount;

  CompareQuizItemGenerator({
    required this.questionsRange,
    required this.answersPool,
    required this.questionSide,
    required this.answerCount,
  });

  List<CompareQuizItem> generate() {
    return List.generate(questionsRange.length, (index) {
      final question = questionsRange[index];
      final variants = answersPool.getRandom(
        count: answerCount,
        exclude: question,
      );

      return CompareQuizItem(
        side: questionSide,
        question: question,
        variants: variants,
      );
    }, growable: false);
  }
}
