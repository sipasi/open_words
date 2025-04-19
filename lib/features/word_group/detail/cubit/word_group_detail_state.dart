part of 'word_group_detail_cubit.dart';

enum LoadingState { loading, loaded }

class WordGroupDetailState {
  final Id id;
  final Id folderId;

  final String name;
  final List<Word> words;

  final LanguageInfo origin;
  final LanguageInfo translation;

  final LoadingState loadingState;

  WordGroupDetailState({
    required this.id,
    required this.folderId,
    required this.name,
    required this.words,
    required this.origin,
    required this.translation,
    required this.loadingState,
  });
  const WordGroupDetailState.initial()
    : id = const Id.empty(),
      folderId = const Id.empty(),
      name = '',
      words = const [],
      origin = const LanguageInfo.empty(),
      translation = const LanguageInfo.empty(),
      loadingState = LoadingState.loading;

  WordGroupDetailState copyWith({
    Id? id,
    Id? folderId,
    String? name,
    List<Word>? words,
    LanguageInfo? origin,
    LanguageInfo? translation,
    LoadingState? loadingState,
  }) {
    return WordGroupDetailState(
      id: id ?? this.id,
      folderId: folderId ?? this.folderId,
      name: name ?? this.name,
      words: words ?? this.words,
      origin: origin ?? this.origin,
      translation: translation ?? this.translation,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
