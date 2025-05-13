part of 'pairs_match_cubit.dart';

class PairsMatchState {
  final QuizScore score;

  final LanguageInfo origin;
  final LanguageInfo translation;

  final PairsMatchSession session;
  final PairsMatchSelection selection;

  final MatchedPairsSet matchedPairs;

  final AnswerHistory answerHistory;

  final GuessGameStatus gameStatus;

  final PairsMatchType matchType;

  PairsMatchState({
    required this.score,
    required this.origin,
    required this.translation,
    required this.session,
    required this.selection,
    required this.matchedPairs,
    required this.answerHistory,
    required this.gameStatus,
    required this.matchType,
  });

  PairsMatchState.initial()
    : score = const QuizScore.initial(),
      origin = const LanguageInfo.empty(),
      translation = const LanguageInfo.empty(),
      session = const PairsMatchSession(),
      selection = const PairsMatchSelection.empty(),
      matchedPairs = const MatchedPairsSet.empty(),
      answerHistory = const AnswerHistory.empty(),
      gameStatus = GuessGameStatus.notStarted,
      matchType = PairsMatchType.wordToWord;

  PairsMatchState.started({
    required this.origin,
    required this.translation,
    required this.session,
    required this.matchType,
  }) : score = QuizScore.start(totalQuestions: session.quizPairCount),
       selection = const PairsMatchSelection.empty(),
       matchedPairs = const MatchedPairsSet.empty(),
       answerHistory = const AnswerHistory.empty(),
       gameStatus = GuessGameStatus.playing;

  PairsMatchState copyWith({
    QuizScore? score,
    LanguageInfo? origin,
    LanguageInfo? translation,
    PairsMatchSession? session,
    PairsMatchSelection? selection,
    MatchedPairsSet? matchedPairs,
    AnswerHistory? answerHistory,
    GuessGameStatus? gameStatus,
    PairsMatchType? matchType,
  }) {
    return PairsMatchState(
      score: score ?? this.score,
      origin: origin ?? this.origin,
      translation: translation ?? this.translation,
      session: session ?? this.session,
      selection: selection ?? this.selection,
      matchedPairs: matchedPairs ?? this.matchedPairs,
      answerHistory: answerHistory ?? this.answerHistory,
      gameStatus: gameStatus ?? this.gameStatus,
      matchType: matchType ?? this.matchType,
    );
  }
}
