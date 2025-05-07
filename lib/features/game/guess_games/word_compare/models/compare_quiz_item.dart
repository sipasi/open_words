import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/shared/quiz/quiz_item.dart';
import 'package:open_words/features/game/shared/quiz/quiz_question_side.dart';

class CompareQuizItem extends QuizItem {
  final Word question;
  final List<Word> variants;

  final QuizQuestionSide side;

  CompareQuizItem({
    required this.question,
    required this.variants,
    required this.side,
  });

  String getQuestionText() => side.question(question);
  String getCorrectAnswerText() => side.variant(question);
  String getVariantTextAt(int index) => side.variant(variants[index]);

  CompareQuizItem copyWith({
    Word? question,
    List<Word>? variants,
    QuizQuestionSide? side,
  }) {
    return CompareQuizItem(
      question: question ?? this.question,
      variants: variants ?? this.variants,
      side: side ?? this.side,
    );
  }
}
