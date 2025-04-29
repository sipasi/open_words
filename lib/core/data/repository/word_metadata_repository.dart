import 'package:drift/drift.dart';
import 'package:open_words/core/data/draft/metadata/word_metadata_draft.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/metadata/word_metadata.dart';
import 'package:open_words/core/data/repository/mappers/word_metadata_raw_sql_mapper.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class WordMetadataRepository {
  Future<WordMetadata?> byWord(String word);
  Future<bool> exist(String word);
  Future<WordMetadata> create(WordMetadataDraft draft);

  Future delete(Id id);
}

class WordMetadataRepositoryImpl extends WordMetadataRepository {
  final AppDriftDatabase database;

  WordMetadataRepositoryImpl(this.database);

  @override
  Future<WordMetadata?> byWord(String word) async {
    final result = await database.transaction(() async {
      final rawMetadata = await database.byWord(word);

      if (rawMetadata == null) {
        return null;
      }

      final metadataId = rawMetadata.read<int>('id');

      final rawPhonetics = await database.phoneticsBy(metadataId);
      final rawMeanings = await database.meaningsBy(metadataId);

      final rawDefinitions = await database.definitionBy(
        rawMeanings.map((e) => e.read<int>('id')),
      );

      return WordMetadataRawSqlMapper.map(
        metadataId: metadataId,
        rawMetadata: rawMetadata,
        phonetics: rawPhonetics,
        meanings: rawMeanings,
        definitions: rawDefinitions,
      );
    });

    return result;
  }

  @override
  Future<WordMetadata> create(WordMetadataDraft draft) async {
    await database.transaction(() async {
      final metadataId = await database.managers.wordMetadatas.create(
        (o) => o(word: draft.word, etymology: draft.etymology),
      );

      await database.managers.phonetics.bulkCreate((o) {
        return [
          for (var phonetic in draft.phonetics)
            o(
              metadataId: metadataId,
              audio: phonetic.audio,
              value: phonetic.value,
            ),
        ];
      });

      for (var meaning in draft.meanings) {
        final meaningId = await database.managers.meanings.create((o) {
          return o(
            metadataId: metadataId,
            partOfSpeech: meaning.partOfSpeech,
            synonyms: meaning.synonyms,
            antonyms: meaning.antonyms,
          );
        });

        await database.managers.definitions.bulkCreate((o) {
          return [
            for (var definition in meaning.definitions)
              o(
                meaningId: meaningId,
                value: definition.value,
                example: definition.example,
              ),
          ];
        });
      }
    });

    final result = await byWord(draft.word);

    return result!;
  }

  @override
  Future<bool> exist(String word) async {
    final exist = await database.exist(word);

    return exist != null;
  }

  @override
  Future delete(Id id) {
    if (id.isEmpty) {
      return Future.value();
    }

    return database.managers.wordMetadatas
        .filter((f) => f.id.equals(id.valueOrThrow()))
        .delete();
  }
}

extension _Queries on AppDriftDatabase {
  Future<QueryRow?> byWord(String word) {
    final query =
        'SELECT * '
        'FROM word_metadatas metadata '
        'WHERE metadata.word = ?;';

    return customSelect(
      query,
      variables: [Variable.withString(word)],
    ).getSingleOrNull();
  }

  Future<QueryRow?> exist(String word) {
    final query =
        'SELECT metadata.id '
        'FROM word_metadatas metadata '
        'WHERE metadata.word = ?;';

    return customSelect(
      query,
      variables: [Variable.withString(word)],
    ).getSingleOrNull();
  }

  Future<List<QueryRow>> phoneticsBy(int metadataId) {
    final query =
        'SELECT * '
        'FROM phonetics '
        'WHERE metadata_id = ?;';

    return customSelect(query, variables: [Variable.withInt(metadataId)]).get();
  }

  Future<List<QueryRow>> meaningsBy(int metadataId) {
    final query =
        'SELECT * '
        'FROM meanings '
        'WHERE metadata_id = ?;';

    return customSelect(query, variables: [Variable.withInt(metadataId)]).get();
  }

  Future<List<QueryRow>> definitionBy(Iterable<int> ids) {
    if (ids.isEmpty) {
      return Future.value([]);
    }

    final placeholders = ids.join(', ');

    final query =
        'SELECT * '
        'FROM definitions '
        'WHERE meaning_id IN ($placeholders);';

    return customSelect(query).get();
  }
}
