class WordDraft {
  final String origin;
  final String translation;

  WordDraft({required this.origin, required this.translation});

  WordDraft copyWith({String? origin, String? translation}) {
    return WordDraft(
      origin: origin ?? this.origin,
      translation: translation ?? this.translation,
    );
  }
}
