import 'package:open_words/core/data/entities/entity.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/metadata/definition.dart';

class Meaning extends Entity {
  final Id metadataId;

  final String partOfSpeech;

  final List<Definition> definitions;

  final List<String> synonyms;

  final List<String> antonyms;

  const Meaning({
    required super.id,
    required this.metadataId,
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });
}
