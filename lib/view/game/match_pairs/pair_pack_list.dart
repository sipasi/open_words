import 'package:open_words/collection/readonly_list.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/match_pairs/pair_pack.dart';

class PairPackList extends ReadonlyList<PairPack> {
  PairPackList._(super._packs);

  static PairPackList create(List<Word> words, [int pairsInPack = 5]) {
    final List<PairPack> packs = [];

    final copy = words.toList()..shuffle();

    int taked = 0;

    while (taked < copy.length) {
      final pack = PairPack.create(copy.skip(taked).take(pairsInPack), shuffle: true);

      packs.add(pack);

      taked += pairsInPack;
    }

    return PairPackList._(packs);
  }
}
