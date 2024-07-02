import 'package:open_words/view/game/match_pairs/pair_part.dart';

class PairsSelector {
  PairPart? _origin;
  PairPart? _translation;

  final bool _canDeselect;

  PairsSelector({bool canDeselect = true}) : _canDeselect = canDeselect;

  bool get originSelected => _origin != null;
  bool get translationSelected => _translation != null;
  bool get bothSelected => originSelected && translationSelected;

  void selectOrigin(PairPart selected) => _onSlelect(
        current: _origin,
        next: selected,
        set: (next) => _origin = next,
      );

  void selectTranslation(PairPart selected) => _onSlelect(
        current: _translation,
        next: selected,
        set: (next) => _translation = next,
      );

  void _onSlelect({required PairPart? current, required PairPart next, required void Function(PairPart?) set}) {
    _onSelection(current, next, set);

    if (bothSelected == false) {
      return;
    }

    _onBothSelected();
  }

  void _onSelection(PairPart? current, PairPart next, void Function(PairPart?) set) {
    if (next != current) {
      set(next);
      current?.unselect();
      next.select();
      return;
    }

    if (_canDeselect == false) {
      return;
    }

    current?.unselect();
    set(null);
  }

  void _onBothSelected() {
    if (_origin!.sameWord(_translation)) {
      _origin!.answer();
      _translation!.answer();
    }

    _origin!.unselect();
    _translation!.unselect();

    _origin = null;
    _translation = null;
  }
}
