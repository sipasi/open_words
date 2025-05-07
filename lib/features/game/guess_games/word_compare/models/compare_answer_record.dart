import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/guess_games/word_compare/models/compare_quiz_item.dart';
import 'package:open_words/features/game/shared/history/answer_record.dart';

class CompareAnswerRecord extends AnswerRecord {
  CompareAnswerRecord({
    required CompareQuizItem quiz,
    required Word userAnswer,
    required bool isCorrect,
  }) : super(
         question: quiz.getQuestionText(),
         answer: quiz.getCorrectAnswerText(),
         userAnswer: quiz.side.variant(userAnswer),
         correct: isCorrect,
       );
}
