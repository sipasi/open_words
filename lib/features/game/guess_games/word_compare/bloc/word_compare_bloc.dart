import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/guess_games/guess_game_status.dart';
import 'package:open_words/features/game/guess_games/word_compare/models/compare_session.dart';
import 'package:open_words/features/game/guess_games/word_compare/utils/compare_answer_evaluator.dart';
import 'package:open_words/features/game/guess_games/word_compare/utils/compare_session_builder.dart';
import 'package:open_words/features/game/guess_games/word_compare/utils/word_compare_state_extension.dart';
import 'package:open_words/features/game/shared/history/answer_history.dart';
import 'package:open_words/features/game/shared/quiz/quiz_score.dart';
import 'package:open_words/features/game/shared/quiz/quiz_score_updater.dart';

part 'word_compare_event.dart';
part 'word_compare_state.dart';

class WordCompareBloc extends Bloc<WordCompareEvent, WordCompareState> {
  final CompareSessionBuilder sessionBuilder;
  final CompareAnswerEvaluator answerEvaluator;
  final QuizScoreUpdater scoreUpdater;

  WordCompareBloc({
    required this.sessionBuilder,
    this.answerEvaluator = const CompareAnswerEvaluator(),
    this.scoreUpdater = const QuizScoreUpdater.allowsIncorrectCompletion(),
  }) : super(WordCompareState.initial()) {
    on<WordCompareStarted>((event, emit) async {
      final session = await sessionBuilder.build();
      final score = QuizScore.start(totalQuestions: session.quizCount);

      emit(
        state.copyWith(
          score: score,
          session: session,
          gameStatus: GuessGameStatus.playing,
        ),
      );
    });

    on<WordCompareAnswerRequested>((event, emit) {
      if (state.gameStatus.isGameEnd) {
        return;
      }

      final isCorrect = answerEvaluator.isCorrectAnswer(
        quiz: state.session.currentQuiz,
        answer: event.value,
      );

      emit(
        state.withNextQuiz(
          scoreUpdater: scoreUpdater,
          isCorrect: isCorrect,
          userAnswer: event.value,
        ),
      );

      if (state.session.allQuizFinished) {
        emit(state.copyWith(gameStatus: GuessGameStatus.gameEnd));

        return;
      }
    });
  }
}
