part of 'word_constructor_cubit.dart';

class WordConstructorState {
  final QuizScore score;

  final WordConstructorSession session;

  final WordPartConstructor answerConstructor;

  final AnswerHistory answerHistory;

  final GuessGameStatus gameStatus;

  bool get answerConstructed => answerConstructor.constructed;
  bool get answerNotConstructed => !answerConstructed;

  WordConstructorState({
    required this.score,
    required this.session,
    required this.answerConstructor,
    required this.answerHistory,
    required this.gameStatus,
  });

  WordConstructorState.initial()
    : score = const QuizScore.initial(),
      session = const WordConstructorSession(),
      answerConstructor = const WordPartConstructor.empty(),
      answerHistory = const AnswerHistory.empty(),
      gameStatus = GuessGameStatus.notStarted;
  WordConstructorState.started(this.session)
    : score = QuizScore.start(totalQuestions: session.quizCount),
      answerConstructor = WordPartConstructor.withCorrectCount(
        session.currentQuiz.answerParts.length,
      ),
      answerHistory = const AnswerHistory.empty(),
      gameStatus = GuessGameStatus.playing;

  WordConstructorState copyWith({
    QuizScore? score,
    WordConstructorSession? session,
    WordPartConstructor? answerConstructor,
    AnswerHistory? answerHistory,
    GuessGameStatus? gameStatus,
  }) {
    return WordConstructorState(
      score: score ?? this.score,
      session: session ?? this.session,
      answerConstructor: answerConstructor ?? this.answerConstructor,
      answerHistory: answerHistory ?? this.answerHistory,
      gameStatus: gameStatus ?? this.gameStatus,
    );
  }
}
