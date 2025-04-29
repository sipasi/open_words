import 'package:open_words/core/data/draft/metadata/definition_draft.dart';
import 'package:open_words/core/data/entities/metadata/meaning.dart';

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
  MeaningDraft.fromMeaning(Meaning meaning)
    : partOfSpeech = meaning.partOfSpeech,
      definitions =
          meaning.definitions.map(DefinitionDraft.fromDefinition).toList(),
      synonyms = meaning.synonyms.toList(),
      antonyms = meaning.antonyms.toList();
}
