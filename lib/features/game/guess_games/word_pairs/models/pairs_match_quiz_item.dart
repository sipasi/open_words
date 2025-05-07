import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_part.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

final class PairsMatchQuizItem extends QuizItem {
  final List<QuestionPart> questions;
  final List<AnswerPart> variants;

  int get length => questions.length;

  PairsMatchQuizItem({required this.questions, required this.variants})
    : assert(questions.length == variants.length);
}
