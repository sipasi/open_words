import 'package:open_words/view/game/answer_record/answer_history.dart';
import 'package:open_words/view/game/answer_record/answer_record.dart';
import 'package:open_words/view/game/guess_game/guess_score.dart';
import 'package:open_words/view/game/guess_game/solve_validator.dart';
import 'package:open_words/view/game/guess_game/word_source.dart';
import 'package:open_words/view/game/word_game.dart';

abstract class WordGuessGame extends WordGame {
  final AnswerHistory _history;
  final GuessScore _score;

  final SolveValidator _validator;

  final QuizPack _quizzes;

  QuizItem get currentQuiz => _quizzes.at(position);

  ReadonlyScore get score => _score;
  ReadonlyHistory get history => _history;

  AttemptTracker get attemptTracker;

  int get packCount => _quizzes.length;

  @override
  bool get last => position + 1 == packCount;

  @override
  bool get canPrev => position > 0;
  @override
  bool get canNext => !last && currentQuiz.allSolved;

  WordGuessGame({
    required QuizPack quizzes,
    required SolveValidator validator,
    required int totalSolved,
    required super.onGameEnd,
  })  : _quizzes = quizzes,
        _validator = validator,
        _history = AnswerHistory(),
        _score = GuessScore(totalSolved);

  void answer({required String question, required String correctAnswer, required String userAnswer}) {
    bool isCorrect = _validator.validateTexts(
      correctAnswer: correctAnswer,
      userAnswer: userAnswer,
    );

    bool isNotCorrect = isCorrect == false;

    if (isNotCorrect && attemptTracker.correctAttemptOnly()) {
      return;
    }

    AnswerRecord record = AnswerRecord(
      question: question,
      answer: correctAnswer,
      userAnswer: userAnswer,
      correct: isCorrect,
    );

    _history.add(record);

    _score.answer(record.correct);

    onAttemptedAsnwer(record);

    if (currentQuiz.allSolved) {
      onAllSolved();
    }
  }

  void onAttemptedAsnwer(AnswerRecord record) {}
  void onAllSolved() {}

  @override
  void restart() {
    super.restart();

    _history.clear();
    _score.clear();

    _quizzes.clear();
  }
}

enum AttemptTracker {
  all,
  correctOnly;

  bool allAttempts() => this == AttemptTracker.all;
  bool correctAttemptOnly() => this == AttemptTracker.correctOnly;
}
