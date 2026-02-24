// test/repositories/word_metadata_repository_test.dart
import 'package:open_words/core/data/repository/word_metadata_repository.dart';
import 'package:test/test.dart';

import 'test_data_drafts.dart';
import 'test_drift_data_source.dart';

void main() {
  late TestDriftDataSource db;
  late WordMetadataRepository repo;

  setUp(() {
    db = TestDriftDataSource();
    repo = WordMetadataRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('WordMetadataRepository', () {
    test('exist() returns false when word does not exist', () async {
      final exists = await repo.exist('missing');
      expect(exists, isFalse);
    });

    test('create() inserts metadata and returns full object', () async {
      final draft = MetadataTestData.base();

      final result = await repo.create(draft);

      expect(
        result.word,
        draft.word,
      );
      expect(
        result.etymology,
        draft.etymology,
      );

      expect(
        result.phonetics.length,
        draft.phonetics.length,
      );
      expect(
        result.phonetics.first.value,
        draft.phonetics.first.value,
      );

      expect(
        result.meanings.length,
        draft.meanings.length,
      );
      expect(
        result.meanings.first.partOfSpeech,
        draft.meanings.first.partOfSpeech,
      );

      expect(
        result.meanings.first.definitions.length,
        draft.meanings.first.definitions.length,
      );
      expect(
        result.meanings.first.definitions.first.value,
        draft.meanings.first.definitions.first.value,
      );
    });

    test('exist() returns true after create()', () async {
      await repo.create(MetadataTestData.base());

      final exists = await repo.exist('test');

      expect(exists, isTrue);
    });

    test('byWord() returns null for missing word', () async {
      final result = await repo.byWord('missing');
      expect(result, isNull);
    });

    test('byWord() returns correct aggregated structure', () async {
      await repo.create(MetadataTestData.base());

      final result = await repo.byWord('test');

      expect(result, isNotNull);
      expect(result!.meanings.single.synonyms, contains('exam'));
      expect(result.meanings.single.antonyms, contains('certainty'));
    });

    test('mapOf() returns only existing words', () async {
      await repo.create(MetadataTestData.base(word: 'one'));
      await repo.create(MetadataTestData.base(word: 'two'));

      final result = await repo.mapOf(['one', 'two', 'three']);

      expect(result.length, 2);
      expect(result.containsKey('one'), isTrue);
      expect(result.containsKey('two'), isTrue);
      expect(result.containsKey('three'), isFalse);
    });

    test('delete() removes metadata', () async {
      final created = await repo.create(MetadataTestData.base());

      await repo.delete(created.id);

      final exists = await repo.exist('test');
      expect(exists, isFalse);
    });

    test(
      'createOrUpdate create or update data and ignores duplicates',
      () async {
        // ARRANGE
        final repo = WordMetadataRepositoryImpl(db);
        final base = MetadataTestData.base();
        final updated = MetadataTestData.updatedFull();

        // ACT 1: create
        await repo.createOrUpdate(base);

        final baseLoaded = await repo.byWord(base.word);

        // ASSERT initial create
        expect(baseLoaded!, isNotNull);
        expect(baseLoaded.etymology, base.etymology);
        expect(baseLoaded.phonetics.length, base.phonetics.length);
        expect(
          baseLoaded.meanings.single.definitions.length,
          base.meanings.single.definitions.length,
        );

        // ACT 2: update
        await repo.createOrUpdate(MetadataTestData.updatedFieldsOnly());

        final updatedLoaded = await repo.byWord(base.word);

        // ASSERT update
        expect(updatedLoaded!.etymology, updated.etymology);

        // phonetics: new added, old not duplicated
        expect(
          updatedLoaded.phonetics.map((e) => e.value),
          containsAll(updated.phonetics.map((e) => e.value)),
        );
        expect(
          updatedLoaded.phonetics.map((e) => e.audio),
          containsAll(updated.phonetics.map((e) => e.audio)),
        );

        // meanings still single noun
        expect(updatedLoaded.meanings.length, updated.meanings.length);

        final metadataNoun = updatedLoaded.meanings.firstWhere(
          (element) => element.partOfSpeech == 'noun',
        );
        final updatedNoun = updated.meanings.firstWhere(
          (element) => element.partOfSpeech == 'noun',
        );

        // definitions merged, not duplicated
        expect(
          metadataNoun.definitions.map((e) => e.value),
          containsAll(updatedNoun.definitions.map((e) => e.value)),
        );

        // synonyms updated
        expect(
          metadataNoun.synonyms,
          containsAll(updatedNoun.synonyms),
        );
      },
    );
  });
}
