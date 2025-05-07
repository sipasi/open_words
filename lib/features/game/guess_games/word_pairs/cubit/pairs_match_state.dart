part of 'pairs_match_cubit.dart';

class PairsMatchState {
  final QuizScore score;

  final PairsMatchSession session;
  final PairsMatchSelection selection;

  final MatchedPairsSet matchedPairs;

  final AnswerHistory answerHistory;

  final PairsMatchGameStatus gameStatus;

  final PairsMatchType matchType;

  PairsMatchState({
    required this.score,
    required this.session,
    required this.selection,
    required this.matchedPairs,
    required this.answerHistory,
    required this.gameStatus,
    required this.matchType,
  });

  PairsMatchState.initial()
    : score = const QuizScore.initial(),
      session = const PairsMatchSession.initial(),
      selection = const PairsMatchSelection.empty(),
      matchedPairs = const MatchedPairsSet.empty(),
      answerHistory = const AnswerHistory.empty(),
      gameStatus = PairsMatchGameStatus.notStarted,
      matchType = PairsMatchType.wordToWord;

  PairsMatchState.started(this.session, this.matchType)
    : score = QuizScore.start(totalQuestions: session.quizPairCount),
      selection = const PairsMatchSelection.empty(),
      matchedPairs = const MatchedPairsSet.empty(),
      answerHistory = const AnswerHistory.empty(),
      gameStatus = PairsMatchGameStatus.playing;

  PairsMatchState copyWith({
    QuizScore? score,
    PairsMatchSession? session,
    PairsMatchSelection? selection,
    MatchedPairsSet? matchedPairs,
    AnswerHistory? answerHistory,
    PairsMatchGameStatus? gameStatus,
    PairsMatchType? matchType,
  }) {
    return PairsMatchState(
      score: score ?? this.score,
      session: session ?? this.session,
      selection: selection ?? this.selection,
      matchedPairs: matchedPairs ?? this.matchedPairs,
      answerHistory: answerHistory ?? this.answerHistory,
      gameStatus: gameStatus ?? this.gameStatus,
      matchType: matchType ?? this.matchType,
    );
  }
}
