class PairState {
  bool _answered = false;
  bool _selected = false;

  bool get answered => _answered;
  bool get selected => _selected;

  void answer() => _answered = true;
  void select() => _selected = true;
  void unselect() => _selected = false;
}
