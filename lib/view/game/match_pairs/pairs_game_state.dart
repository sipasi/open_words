import 'package:open_words/collection/linq_iterable.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/match_pairs/pair_pack.dart';
import 'package:open_words/view/game/match_pairs/pair_pack_list.dart';

class PairsGameState {
  final PairPackList _packs;

  int _index = 0;

  int get count => _packs.length;

  double get answeredPairsPercentage =>
      _packs.sumBy((element) => element.answeredPairs) / _packs.sumBy((element) => element.count);

  bool get lastPack => _index + 1 == count;

  bool get gameEnd => lastPack && current.completed;

  PairPack get current => _packs[_index];

  PairsGameState(this._packs);
  PairsGameState.copyWords(List<Word> words) : _packs = PairPackList.create(words.toList(growable: false));

  void tryNextPack() {
    if (current.notCompleted || lastPack) {
      return;
    }

    _index = _index + 1;
  }
}
