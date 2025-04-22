import 'package:open_words/core/data/draft/metadata/definition_draft.dart';

class MeaningDraft {
  final String partOfSpeech;

  final List<DefinitionDraft> definitions;

  final List<String> synonyms;

  final List<String> antonyms;

  MeaningDraft({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });
}
