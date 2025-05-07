import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/guess_games/word_compare/bloc/word_compare_bloc.dart';
import 'package:open_words/features/game/shared/history/answer_record.dart';
import 'package:open_words/features/game/shared/quiz/quiz_score_updater.dart';

extension WordCompareStateExtension on WordCompareState {
  WordCompareState withNextQuiz({
    required bool isCorrect,
    required Word userAnswer,
    required QuizScoreUpdater scoreUpdater,
  }) {
    return copyWith(
      session: session.copyWithNextQuiz(),
      score: scoreUpdater.copyWithAnswer(score, isCorrect),
      answerHistory: answerHistory.add(
        AnswerRecord(
          question: session.currentQuiz.getQuestionText(),
          answer: session.currentQuiz.getCorrectAnswerText(),
          userAnswer: session.currentQuiz.side.variant(userAnswer),
          correct: isCorrect,
        ),
      ),
    );
  }
}
