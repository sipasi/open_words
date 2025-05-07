import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/guess_games/word_compare/bloc/word_compare_bloc.dart';
import 'package:open_words/features/game/guess_games/word_compare/models/compare_answer_record.dart';
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
        CompareAnswerRecord(
          quiz: session.currentQuiz,
          userAnswer: userAnswer,
          isCorrect: isCorrect,
        ),
      ),
    );
  }
}
