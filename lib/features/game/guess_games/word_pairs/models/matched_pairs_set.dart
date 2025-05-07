import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_part.dart';

final class MatchedPairsSet {
  final Set<PairsPart> _matched;

  const MatchedPairsSet(this._matched);
  const MatchedPairsSet.empty() : _matched = const {};

  bool hasDifferentQuestionCountThan(int expected) =>
      _matched.length / 2 != expected;

  bool contains(PairsPart value) => _matched.contains(value);

  MatchedPairsSet add(PairsPart question, PairsPart answer) {
    return MatchedPairsSet(
      _matched.toSet()
        ..add(question)
        ..add(answer),
    );
  }

  MatchedPairsSet clear() {
    return const MatchedPairsSet.empty();
  }
}
