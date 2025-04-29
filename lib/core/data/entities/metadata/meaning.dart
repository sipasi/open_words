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

  Meaning deepCopy() {
    return copyWith(
      metadataId: metadataId,
      partOfSpeech: partOfSpeech,
      definitions: definitions.map((e) => e.copyWith()).toList(),
      synonyms: synonyms.toList(),
      antonyms: antonyms.toList(),
    );
  }

  Meaning copyWith({
    Id? id,
    Id? metadataId,
    String? partOfSpeech,
    List<Definition>? definitions,
    List<String>? synonyms,
    List<String>? antonyms,
  }) {
    return Meaning(
      id: id ?? this.id,
      metadataId: metadataId ?? this.metadataId,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definitions: definitions ?? this.definitions,
      synonyms: synonyms ?? this.synonyms,
      antonyms: antonyms ?? this.antonyms,
    );
  }
}
