part of 'editor_meaning_cubit.dart';

class EditorMeaningState {
  final String partOfSpeech;
  final List<Definition> definitions;
  final List<Definition> definitionsRemoved;
  final String synonyms;
  final String antonyms;

  bool get canSubmit =>
      partOfSpeech.isNotEmpty &&
      (definitions.isNotEmpty || synonyms.isNotEmpty || antonyms.isNotEmpty);
  bool get canNotSubmit => !canSubmit;

  EditorMeaningState({
    required this.partOfSpeech,
    required this.definitions,
    required this.definitionsRemoved,
    required this.synonyms,
    required this.antonyms,
  });

  EditorMeaningState.initial()
    : partOfSpeech = '',
      definitions = const [],
      definitionsRemoved = const [],
      synonyms = '',
      antonyms = '';

  EditorMeaningState copyWith({
    String? partOfSpeech,
    List<Definition>? definitions,
    List<Definition>? definitionsRemoved,
    String? synonym,
    String? antonym,
  }) {
    return EditorMeaningState(
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definitions: definitions ?? this.definitions,
      definitionsRemoved: definitionsRemoved ?? this.definitionsRemoved,
      synonyms: synonym ?? synonyms,
      antonyms: antonym ?? antonyms,
    );
  }
}
