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

  Future createOrUpdateAll(List<WordMetadataDraft> drafts);

  Future<Map<String, WordMetadata>> mapOf(List<String> words);

  Future delete(Id id);
}

class WordMetadataRepositoryImpl extends WordMetadataRepository {
  final AppDriftDatabase database;

  WordMetadataRepositoryImpl(this.database);

  @override
  Future<WordMetadata?> byWord(String word) async {
    final rawMetadata = await database.byWord(word).getSingleOrNull();

    if (rawMetadata == null) {
      return null;
    }

    final metadataId = rawMetadata.read<int>('id');

    final phoneticsMeanings = await Future.wait([
      database.phoneticsBy(metadataId).get(),
      database.meaningsBy(metadataId).get(),
    ]);

    final rawPhonetics = phoneticsMeanings[0];
    final rawMeanings = phoneticsMeanings[1];

    final rawDefinitions = await database
        .definitionBy(
          rawMeanings.map((e) => e.read<int>('id')),
        )
        .get();

    return WordMetadataRawSqlMapper.map(
      metadataId: metadataId,
      rawMetadata: rawMetadata,
      phonetics: rawPhonetics,
      meanings: rawMeanings,
      definitions: rawDefinitions,
    );
  }

  @override
  Future<bool> exist(String word) async {
    final exist = await database.exist(word).getSingleOrNull();

    return exist != null;
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
  Future createOrUpdateAll(List<WordMetadataDraft> drafts) async {
    return Future.wait(
      drafts.map((e) => createOrUpdate(e)),
    );
  }

  Future createOrUpdate(WordMetadataDraft draft) async {
    if (await exist(draft.word) == false) {
      return create(draft);
    }

    await database.transaction(() async {
      final metadata = (await byWord(draft.word))!;

      // 1. Word
      database.managers.wordMetadatas
          .filter((f) => f.word.equals(draft.word))
          .update(
            (o) => o(etymology: Value.absentIfNull(draft.etymology)),
          );

      // 2. Phonetics
      await Future.wait(
        draft.phonetics.map(
          (e) => database
              .into(database.phonetics)
              .insertOnConflictUpdate(
                PhoneticsCompanion.insert(
                  metadataId: metadata.id.valueOrThrow(),
                  value: e.value,
                  audio: e.audio,
                ),
              ),
        ),
      );

      // 3. Meanings
      for (final meaning in draft.meanings) {
        final meaningId = await database
            .into(database.meanings)
            .insertOnConflictUpdate(
              MeaningsCompanion.insert(
                metadataId: metadata.id.valueOrThrow(),
                partOfSpeech: meaning.partOfSpeech,
                synonyms: meaning.synonyms,
                antonyms: meaning.antonyms,
              ),
            );

        // 4. Definitions
        await Future.wait(
          meaning.definitions.map(
            (e) => database
                .into(database.definitions)
                .insertOnConflictUpdate(
                  DefinitionsCompanion.insert(
                    meaningId: meaningId,
                    value: e.value,
                    example: e.example,
                  ),
                ),
          ),
        );
      }
    });
  }

  @override
  Future<Map<String, WordMetadata>> mapOf(List<String> words) async {
    if (words.isEmpty) return {};

    final Map<String, WordMetadata> result = {};

    final res = await database.transaction(
      () => Future.wait(words.map(byWord)),
    );

    for (var element in res) {
      if (element != null) {
        result[element.word] = element;
      }
    }

    return result;
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
  Selectable<QueryRow> byWord(String word) {
    final query =
        'SELECT * '
        'FROM word_metadatas metadata '
        'WHERE metadata.word = ?;';

    return customSelect(
      query,
      variables: [Variable.withString(word)],
      readsFrom: {wordMetadatas},
    );
  }

  Selectable<QueryRow> exist(String word) {
    final query =
        'SELECT metadata.id '
        'FROM word_metadatas metadata '
        'WHERE metadata.word = ?;';

    return customSelect(
      query,
      variables: [Variable.withString(word)],
      readsFrom: {wordMetadatas},
    );
  }

  Selectable<QueryRow> phoneticsBy(int metadataId) {
    final query =
        'SELECT * '
        'FROM phonetics '
        'WHERE metadata_id = ?;';

    return customSelect(
      query,
      variables: [Variable.withInt(metadataId)],
      readsFrom: {phonetics},
    );
  }

  Selectable<QueryRow> meaningsBy(int metadataId) {
    final query =
        'SELECT * '
        'FROM meanings '
        'WHERE metadata_id = ? '
        'ORDER BY part_of_speech';

    return customSelect(
      query,
      variables: [Variable.withInt(metadataId)],
      readsFrom: {meanings},
    );
  }

  Selectable<QueryRow> definitionBy(Iterable<int> ids) {
    final placeholders = ids.join(', ');

    final query =
        'SELECT * '
        'FROM definitions '
        'WHERE meaning_id IN ($placeholders);';

    return customSelect(
      query,
      readsFrom: {definitions},
    );
  }
}
