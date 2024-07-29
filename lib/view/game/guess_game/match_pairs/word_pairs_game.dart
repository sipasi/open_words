import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/answer_record/answer_record.dart';
import 'package:open_words/view/game/guess_game/match_pairs/pair_quiz_item.dart';
import 'package:open_words/view/game/guess_game/match_pairs/pairs_selector.dart';
import 'package:open_words/view/game/guess_game/solve_validator.dart';
import 'package:open_words/view/game/guess_game/word_question_side.dart';
import 'package:open_words/view/game/guess_game/word_source.dart';

import '../word_guess_game.dart';

class WordPairsGame extends WordGuessGame {
  final PairsSelector _selector;

  @override
  AttemptTracker get attemptTracker => AttemptTracker.correctOnly;

  @override
  PairQuizItem get currentQuiz => super.currentQuiz as PairQuizItem;

  WordPairsGame({
    required super.totalSolved,
    required super.quizzes,
    required super.validator,
    required super.onGameEnd,
    required WordQuestionSide questionSide,
  }) : _selector = PairsSelector(questionSide: questionSide, canDeselect: false);

  factory WordPairsGame.create({
    required List<Word> words,
    required void Function() onGameEnd,
    SolveValidator validator = SolveValidator.byVariantSide,
    WordQuestionSide questionSide = WordQuestionSide.origin,
  }) {
    return WordPairsGame(
      totalSolved: words.length,
      questionSide: questionSide,
      quizzes: QuizPack(PairQuizCreator.list(words, questionSide)),
      validator: validator,
      onGameEnd: onGameEnd,
    );
  }

  void selectQuestion(int index) => _select(_selector.selectQuestion, index);

  void selectVariant(int index) => _select(_selector.selectVariant, index);

  @override
  void onAttemptedAsnwer(AnswerRecord record) {
    currentQuiz.markAsSolved(_selector.question!.word, _selector.variant!.word);
  }

  @override
  void onAllSolved() {
    next();
  }

  void _select(void Function(PairQuizItem, int) selection, int index) {
    selection(currentQuiz, index);

    if (_selector.bothSelected) {
      answer(
        question: _selector.questionText!,
        correctAnswer: _selector.correctVariantText!,
        userAnswer: _selector.userVariantText!,
      );

      _selector.handleIfBothSelected(currentQuiz);
    }
  }
}
