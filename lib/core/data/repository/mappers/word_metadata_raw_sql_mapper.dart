import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/entity_id.dart';
import 'package:open_words/core/data/entities/metadata/definition.dart';
import 'package:open_words/core/data/entities/metadata/meaning.dart';
import 'package:open_words/core/data/entities/metadata/phonetic.dart';
import 'package:open_words/core/data/entities/metadata/word_metadata.dart';
import 'package:open_words/core/data/sources/drift/synonym_antonym_converter.dart';

sealed class WordMetadataRawSqlMapper {
  static const synonymAntonym = SynonymAntonymConverter();

  static WordMetadata map({
    required int metadataId,
    required QueryRow rawMetadata,
    required List<QueryRow> phonetics,
    required List<QueryRow> meanings,
    required List<QueryRow> definitions,
  }) {
    final id = EntityId.exist(metadataId);

    return WordMetadata(
      id: id,
      word: rawMetadata.read('word'),
      etymology: rawMetadata.read('etymology'),
      phonetics: _mapPhonetics(id, phonetics),
      meanings: _mapMeanings(id, meanings, definitions),
    );
  }

  static List<Phonetic> _mapPhonetics(
    EntityId metadataId,
    List<QueryRow> phonetics,
  ) {
    return phonetics
        .map(
          (e) => Phonetic(
            id: EntityId.exist(e.read('id')),
            metadataId: metadataId,
            value: e.read('value'),
            audio: e.read('audio'),
          ),
        )
        .toList();
  }

  static List<Meaning> _mapMeanings(
    EntityId metadataId,
    List<QueryRow> meanings,
    List<QueryRow> definitions,
  ) {
    return meanings.map((e) {
      final meaningId = EntityId.exist(e.read('id'));

      return Meaning(
        id: meaningId,
        metadataId: metadataId,
        partOfSpeech: e.read('part_of_speech'),
        definitions: _mapDefinitions(meaningId, meanings, definitions),
        synonyms: synonymAntonym.fromSql(e.read('synonyms')),
        antonyms: synonymAntonym.fromSql(e.read('antonyms')),
      );
    }).toList();
  }

  static List<Definition> _mapDefinitions(
    EntityId meaningId,
    List<QueryRow> meanings,
    List<QueryRow> definitions,
  ) {
    return definitions
        .where(
          (element) =>
              element.read<int>('meaning_id') == meaningId.valueOrThrow(),
        )
        .map(
          (e) => Definition(
            id: EntityId.exist(e.read('id')),
            meaningId: meaningId,
            value: e.read('value'),
            example: e.read('example'),
          ),
        )
        .toList();
  }
}
