import 'package:open_words/collection/list_randomizer.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/answer_record/answer_record.dart';
import 'package:open_words/view/game/guess_game/solve_validator.dart';
import 'package:open_words/view/game/guess_game/word_question_side.dart';
import 'package:open_words/view/game/guess_game/word_source.dart';

import '../word_guess_game.dart';
import 'constructor_quiz_item.dart';

class WordConstructorGame extends WordGuessGame {
  @override
  ConstructorQuizItem get currentQuiz => super.currentQuiz as ConstructorQuizItem;

  @override
  AttemptTracker get attemptTracker => AttemptTracker.all;

  factory WordConstructorGame({
    required List<Word> words,
    required WordQuestionSide questionSide,
    required void Function() onGameEnd,
  }) {
    List<ConstructorQuizItem> quizzes = List.generate(
      words.length,
      (index) {
        final word = words[index];

        return ConstructorQuizItem.byTwoLetter(word, questionSide);
      },
    );

    quizzes.randomize(times: 5);

    return WordConstructorGame._(
      totalSolved: words.length,
      quizzes: QuizPack(quizzes),
      validator: SolveValidator.byVariantSide,
      onGameEnd: onGameEnd,
    );
  }

  WordConstructorGame._({
    required super.totalSolved,
    required super.quizzes,
    required super.validator,
    required super.onGameEnd,
  });
  @override
  void onAttemptedAsnwer(AnswerRecord record) {
    if (last) {
      next();
    }
  }

  void onAnswerTap(int id) => _onTap(() => currentQuiz.onAnswerTap(id));

  void onVariantTap(int id) => _onTap(() => currentQuiz.onVariantTap(id));

  void _onTap(void Function() tapHandler) {
    if (currentQuiz.constructed) {
      return;
    }

    tapHandler();

    if (currentQuiz.constructed == false) {
      return;
    }

    answer(
      question: currentQuiz.question,
      correctAnswer: currentQuiz.answer,
      userAnswer: currentQuiz.constructedText,
    );
  }
}
