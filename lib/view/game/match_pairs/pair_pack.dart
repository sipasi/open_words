import 'package:open_words/data/word/word.dart';

import 'pair_part.dart';

class PairPack {
  final List<PairPart> _origins;
  final List<PairPart> _translations;

  bool get completed => _origins.every(_isAnswered) && _translations.every(_isAnswered);
  bool get notCompleted => completed == false;

  int get all => _origins.length * 2;
  int get count => _origins.length;
  int get answeredPairs => _origins.map((e) => e.answered ? 1 : 0).reduce((value, element) => value + element);

  PairPack._(this._origins, this._translations);

  PairPart originAt(int index) => _origins[index];
  PairPart translationAt(int index) => _translations[index];

  static PairPack create(Iterable<Word> words, {required bool shuffle}) {
    final origins = <PairPart>[];
    final translations = <PairPart>[];

    for (var word in words) {
      origins.add(PairPart.origin(word));
      translations.add(PairPart.translation(word));
    }

    if (shuffle) {
      for (var i = 0; i < 10; i++) {
        origins.shuffle();
        translations.shuffle();
      }
    }

    return PairPack._(origins, translations);
  }

  static bool _isAnswered(PairPart card) => card.answered;
}
