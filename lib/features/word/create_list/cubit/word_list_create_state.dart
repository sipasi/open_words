part of 'word_list_create_cubit.dart';

class WordListCreateState {
  final String originDraft;
  final String translationDraft;

  final List<WordDraft> drafts;

  final bool aiAvailable;

  const WordListCreateState({
    required this.originDraft,
    required this.translationDraft,
    required this.drafts,
    required this.aiAvailable,
  });

  const WordListCreateState.initial()
    : drafts = const [],
      originDraft = '',
      translationDraft = '',
      aiAvailable = false;

  WordListCreateState copyWith({
    String? originDraft,
    String? translationDraft,
    List<WordDraft>? drafts,
    bool? aiAvailable,
  }) {
    return WordListCreateState(
      originDraft: originDraft ?? this.originDraft,
      translationDraft: translationDraft ?? this.translationDraft,
      drafts: drafts ?? this.drafts,
      aiAvailable: aiAvailable ?? this.aiAvailable,
    );
  }
}
