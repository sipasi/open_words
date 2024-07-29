import 'package:open_words/collection/list_randomizer.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/guess_game/word_question_side.dart';
import 'package:open_words/view/game/guess_game/word_source.dart';

import 'pair_part.dart';

class PairQuizItem extends QuizItem {
  final List<PairPart> _questions;
  final List<PairPart> _variants;

  int get count => _questions.length;

  @override
  bool get allSolved => _questions.every(_isAnswered) && _variants.every(_isAnswered);

  PairQuizItem._(this._questions, this._variants);

  PairPart questionAt(int index) => _questions[index];
  PairPart variantAt(int index) => _variants[index];

  void markAsSolvedAt(int question, int variant) {
    _questions[question].markAsSolved();
    _variants[variant].markAsSolved();
  }

  void markAsSolved(Word question, Word variant) {
    final questionPair = _questions.firstWhere((element) => element.word == question);
    final variantPair = _variants.firstWhere((element) => element.word == variant);

    questionPair.markAsSolved();
    variantPair.markAsSolved();
  }

  @override
  void clear() {
    for (var element in _questions) {
      element.clear();
    }
    for (var element in _variants) {
      element.clear();
    }
  }

  static bool _isAnswered(PairPart card) => card.solved;
}

class PairQuizCreator {
  static PairQuizItem single(Iterable<Word> words, WordQuestionSide questionSide, {required bool shuffle}) {
    final origins = <PairPart>[];
    final translations = <PairPart>[];

    for (var word in words) {
      origins.add(PairPart(word, questionSide.question(word)));
      translations.add(PairPart(word, questionSide.variant(word)));
    }

    if (shuffle) {
      origins.randomize(times: 10);
      translations.randomize(times: 10);
    }

    return PairQuizItem._(origins, translations);
  }

  static List<PairQuizItem> list(List<Word> words, WordQuestionSide questionSide, [int pairsInPack = 5]) {
    final List<PairQuizItem> packs = [];

    final copy = words.toList()..randomize(times: 10);

    int taked = 0;

    while (taked < copy.length) {
      final pack = single(copy.skip(taked).take(pairsInPack), questionSide, shuffle: true);

      packs.add(pack);

      taked += pairsInPack;
    }

    return packs;
  }
}
