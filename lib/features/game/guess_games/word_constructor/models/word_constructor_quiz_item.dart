import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_part.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

class WordConstructorQuizItem extends QuizItem {
  final Word word;

  final String question;
  final String correctAnswer;
  final List<WordPart> answerParts;

  WordConstructorQuizItem({
    required this.word,
    required this.question,
    required this.correctAnswer,
    required this.answerParts,
  });
}
