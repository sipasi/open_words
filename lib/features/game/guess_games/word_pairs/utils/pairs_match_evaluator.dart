import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_part.dart';

final class PairsMatchEvaluator {
  const PairsMatchEvaluator();

  bool isCorrectAnswer({
    required PairsPart question,
    required PairsPart answer,
  }) {
    return question.word == answer.word;
  }
}
