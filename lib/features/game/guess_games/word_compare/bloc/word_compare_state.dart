part of 'word_compare_bloc.dart';

class WordCompareState {
  final QuizScore score;
  final CompareSession session;
  final AnswerHistory answerHistory;
  final CompareGameStatus gameStatus;

  WordCompareState({
    required this.score,
    required this.session,
    required this.answerHistory,
    required this.gameStatus,
  });

  WordCompareState.initial()
    : score = const QuizScore.initial(),
      session = const CompareSession.initial(),
      answerHistory = AnswerHistory.empty(),
      gameStatus = CompareGameStatus.notStarted;

  WordCompareState copyWith({
    QuizScore? score,
    CompareSession? session,
    AnswerHistory? answerHistory,
    CompareGameStatus? gameStatus,
  }) {
    return WordCompareState(
      score: score ?? this.score,
      session: session ?? this.session,
      answerHistory: answerHistory ?? this.answerHistory,
      gameStatus: gameStatus ?? this.gameStatus,
    );
  }
}
