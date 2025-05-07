import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/word/word.dart';

part 'game_list_state.dart';

class GameListCubit extends Cubit<GameListState> {
  final String groupName;
  final List<Word> words;
  final int minWordCountUpperLimit;

  GameListCubit({
    required this.groupName,
    required this.words,
    required this.minWordCountUpperLimit,
  }) : super(GameListState.initial());

  void init() {
    final min = minWordCountUpperLimit;
    final max = words.length < min ? min : words.length;
    late final int divisions;

    if (max != min && max <= min * 2) {
      divisions = max - min;
    } else {
      divisions = (max / min).round();
    }

    emit(
      GameListState(
        wordRange: SelectableWordRange(
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: divisions,
          selectedValue: min.toDouble(),
        ),
      ),
    );
  }

  void setSelectedRangeValue(double value) {
    emit(
      state.copyWith(wordRange: state.wordRange.copyWith(selectedValue: value)),
    );
  }
}
