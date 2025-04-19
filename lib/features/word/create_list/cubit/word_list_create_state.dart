part of 'word_list_create_cubit.dart';

class WordListCreateState {
  final List<WordDraft> drafts;

  const WordListCreateState({required this.drafts});
  const WordListCreateState.intial() : drafts = const [];

  WordListCreateState copyWith({
    List<WordDraft>? drafts,
  }) {
    return WordListCreateState(
      drafts: drafts ?? this.drafts,
    );
  }
}
