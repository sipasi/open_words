import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/repository/word_statistic_repository.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_status.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_constructor_session.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_part.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_part_constructor.dart';
import 'package:open_words/features/game/guess_games/word_constructor/utils/word_constructor_evaluator.dart';
import 'package:open_words/features/game/guess_games/word_constructor/utils/word_constructor_session_builder.dart';
import 'package:open_words/features/game/shared/history/answer_history.dart';
import 'package:open_words/features/game/shared/history/answer_record.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';
import 'package:open_words/features/game/shared/quiz/quiz_score_updater.dart';

part 'word_constructor_state.dart';

class WordConstructorCubit extends Cubit<WordConstructorState> {
  WordConstructorSessionBuilder sessionBuilder;

  final WordStatisticRepository wordStatisticRepository;

  final scoreUpdater = const QuizScoreUpdater(QuizCompletionPolicy.anyAttempt);
  final constructorEvaluator = const WordConstructorEvaluator();

  WordConstructorCubit({
    required this.sessionBuilder,
    required this.wordStatisticRepository,
  }) : super(WordConstructorState.initial());

  Future started() async {
    emit(WordConstructorState.started(sessionBuilder.build()));
  }

  void addConstructablePart(WordPart part) {
    emit(
      state.copyWith(
        answerConstructor: state.answerConstructor.copyWithPart(part),
      ),
    );

    if (state.answerNotConstructed) {
      return;
    }

    final isCorrect = constructorEvaluator.isCorrectAnswer(
      correctAnswer: state.session.currentQuiz.correctAnswer,
      userAnswer: state.answerConstructor.constructedString,
    );

    wordStatisticRepository.addDependsTo(
      state.session.currentQuiz.word.origin,
      isCorrect,
    );

    emit(
      state.copyWith(
        score: scoreUpdater.copyWithAnswer(state.score, isCorrect),
        answerHistory: state.answerHistory.add(
          AnswerRecord(
            question: state.session.currentQuiz.question,
            answer: state.session.currentQuiz.correctAnswer,
            userAnswer: state.answerConstructor.constructedString,
            correct: isCorrect,
          ),
        ),
        session: state.session.copyWithNextQuiz(),
      ),
    );

    if (state.session.allQuizFinished) {
      emit(state.copyWith(gameStatus: GuessGameStatus.gameEnd));

      return;
    }

    emit(
      state.copyWith(
        answerConstructor: WordPartConstructor.withCorrectCount(
          state.session.currentQuiz.answerParts.length,
        ),
      ),
    );
  }

  void removeConstructablePart(WordPart part) {
    emit(
      state.copyWith(
        answerConstructor: state.answerConstructor.copyWithoutPart(part),
      ),
    );
  }
}
