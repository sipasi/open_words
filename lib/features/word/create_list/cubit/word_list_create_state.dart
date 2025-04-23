part of 'word_list_create_cubit.dart';

class WordListCreateState {
  final String originDraft;
  final String translationDraft;

  final List<WordDraft> drafts;

  const WordListCreateState({
    required this.originDraft,
    required this.translationDraft,
    required this.drafts,
  });

  const WordListCreateState.initial()
    : drafts = const [],
      originDraft = '',
      translationDraft = '';

  WordListCreateState copyWith({
    String? originDraft,
    String? translationDraft,
    List<WordDraft>? drafts,
  }) {
    return WordListCreateState(
      originDraft: originDraft ?? this.originDraft,
      translationDraft: translationDraft ?? this.translationDraft,
      drafts: drafts ?? this.drafts,
    );
  }
}
