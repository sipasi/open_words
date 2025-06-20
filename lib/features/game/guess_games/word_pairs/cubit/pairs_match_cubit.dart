import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/repository/word_statistic_repository.dart';
import 'package:open_words/core/services/text_to_speech/text_to_speech_service.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_status.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/matched_pairs_set.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_match_selection.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_match_session.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_match_type.dart';
import 'package:open_words/features/game/guess_games/word_pairs/utils/pairs_match_evaluator.dart';
import 'package:open_words/features/game/guess_games/word_pairs/utils/pairs_match_session_builder.dart';
import 'package:open_words/features/game/shared/history/answer_history.dart';
import 'package:open_words/features/game/shared/history/answer_record.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';
import 'package:open_words/features/game/shared/quiz/quiz_score_updater.dart';

part 'pairs_match_state.dart';

enum PairsMatchEvaluateEvent {
  correct,
  wrong;

  static PairsMatchEvaluateEvent from(bool result) {
    return result ? correct : wrong;
  }
}

enum QuestionViewType { text, audio }

class PairsMatchCubit extends Cubit<PairsMatchState> {
  final _answerEvent = StreamController<PairsMatchEvaluateEvent>.broadcast();

  Stream<PairsMatchEvaluateEvent> get answerEvents => _answerEvent.stream;

  final WordStatisticRepository wordStatisticRepository;

  final LanguageInfo origin;
  final LanguageInfo translation;
  final TextToSpeechService textToSpeech;

  final PairsMatchSessionBuilder sessionBuilder;
  final PairsMatchEvaluator matchEvaluator;
  final QuizScoreUpdater scoreUpdater;
  final PairsMatchType matchType;

  PairsMatchCubit({
    required this.wordStatisticRepository,
    required this.origin,
    required this.translation,
    required this.textToSpeech,
    required this.sessionBuilder,
    required this.matchEvaluator,
    required this.matchType,
  }) : scoreUpdater = const QuizScoreUpdater.allowsCorrectOnlyCompletion(),
       super(PairsMatchState.initial());

  @override
  Future<void> close() async {
    await _answerEvent.close();
    await super.close();
  }

  Future started() async {
    final session = sessionBuilder.build();

    emit(
      PairsMatchState.started(
        origin: origin,
        translation: translation,
        session: session,
        matchType: matchType,
      ),
    );
  }

  void selectQuestion(int index) {
    if (state.selection.both || state.selection.question == index) {
      return;
    }

    emit(
      state.copyWith(
        selection: state.selection.copyWith(question: () => index),
      ),
    );

    if (state.selection.both) {
      onBothSelected();
    }
  }

  void selectAnswer(int index) {
    if (state.selection.both || state.selection.answer == index) {
      return;
    }

    emit(
      state.copyWith(selection: state.selection.copyWith(answer: () => index)),
    );

    if (state.selection.both) {
      onBothSelected();
    }
  }

  Future onBothSelected() async {
    final currentQuiz = state.session.currentQuiz;

    final question = currentQuiz.questions[state.selection.question!];
    final answer = currentQuiz.variants[state.selection.answer!];

    final isCorrect = matchEvaluator.isCorrectAnswer(
      question: question,
      answer: answer,
    );

    wordStatisticRepository.addDependsTo(question.word.origin, isCorrect);
    wordStatisticRepository.addDependsTo(answer.word.origin, isCorrect);

    emit(
      state.copyWith(
        selection: state.selection.copyWith(isCorrect: () => isCorrect),
      ),
    );

    await Future.delayed(Duration(milliseconds: 300));

    emit(state.copyWith(selection: state.selection.copyWithDeselection()));

    emit(
      state.copyWith(
        score: scoreUpdater.copyWithAnswer(state.score, isCorrect),
        answerHistory: state.answerHistory.add(
          AnswerRecord(
            question: question.text,
            answer: question.correctAnswer,
            userAnswer: answer.text,
            correct: isCorrect,
          ),
        ),
      ),
    );

    if (isCorrect == false) {
      return;
    }

    emit(
      state.copyWith(matchedPairs: state.matchedPairs.add(question, answer)),
    );

    if (state.matchedPairs.hasDifferentQuestionCountThan(
      state.session.currentQuiz.length,
    )) {
      return;
    }

    emit(state.copyWith(session: state.session.copyWithNextQuiz()));

    if (state.session.allQuizFinished) {
      emit(state.copyWith(gameStatus: GuessGameStatus.gameEnd));
      return;
    }

    emit(state.copyWith(matchedPairs: state.matchedPairs.clear()));
  }

  void speechOrigin(String text) {
    textToSpeech.stopAndSpeek(text: text, language: origin);
  }
}
