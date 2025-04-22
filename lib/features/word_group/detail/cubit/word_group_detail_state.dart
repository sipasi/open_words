part of 'word_group_detail_cubit.dart';

enum LoadingState { loading, loaded }

class WordGroupDetailState {
  final WordGroup group;

  final List<Word> words;

  final LoadingState loadingState;

  WordGroupDetailState({
    required this.words,
    required this.group,
    required this.loadingState,
  });

  const WordGroupDetailState.initial(this.group)
    : words = const [],
      loadingState = LoadingState.loading;

  WordGroupDetailState copyWith({
    List<Word>? words,
    WordGroup? group,
    LoadingState? loadingState,
  }) {
    return WordGroupDetailState(
      words: words ?? this.words,
      group: group ?? this.group,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
