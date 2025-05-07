import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

sealed class PairsPart {
  final Word word;
  final QuizQuestionSide side;

  String get text;

  PairsPart({required this.word, required this.side});
}

final class QuestionPart extends PairsPart {
  @override
  String get text => side.question(word);

  String get correctAnswer => side.variant(word);

  QuestionPart({required super.word, required super.side});
}

final class AnswerPart extends PairsPart {
  @override
  String get text => side.variant(word);

  AnswerPart({required super.word, required super.side});
}
