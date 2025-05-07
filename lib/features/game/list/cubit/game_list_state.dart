part of 'game_list_cubit.dart';

class SelectableWordRange {
  final double min;
  final double max;

  final double selectedValue;

  final int divisions;

  bool get selectedMin => selectedValue == min;
  bool get selectedMax => selectedValue == max;
  bool get hasSelectableWordRange => max > min && max - min >= 3;

  SelectableWordRange({
    required this.min,
    required this.max,
    required this.divisions,
    required this.selectedValue,
  });
  SelectableWordRange.empty()
    : min = 0,
      max = 0,
      divisions = 0,
      selectedValue = 0;

  SelectableWordRange copyWith({
    double? min,
    double? max,
    double? selectedValue,
    int? divisions,
  }) {
    return SelectableWordRange(
      min: min ?? this.min,
      max: max ?? this.max,
      divisions: divisions ?? this.divisions,
      selectedValue: selectedValue ?? this.selectedValue,
    );
  }
}

class GameListState {
  final SelectableWordRange wordRange;

  GameListState({required this.wordRange});
  GameListState.initial() : wordRange = SelectableWordRange.empty();

  GameListState copyWith({SelectableWordRange? wordRange}) {
    return GameListState(wordRange: wordRange ?? this.wordRange);
  }
}
