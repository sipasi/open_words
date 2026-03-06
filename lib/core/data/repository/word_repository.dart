import 'package:open_words/core/data/draft/word_draft.dart';
import 'package:open_words/core/data/entities/entity_id.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/repository/mappers/word_sql_mapper.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';
import 'package:open_words/core/data/sources/drift/tables/word_query.dart';

sealed class WordRepository {
  Future<List<Word>> allByGroup(EntityId group);

  Future<int> create({
    required EntityId group,
    required String origin,
    required String translation,
  });

  Future createAll({required EntityId groupId, required List<WordDraft> drafts});

  Future delete(EntityId id);
}

class WordRepositoryImpl extends WordRepository {
  final AppDriftDatabase database;

  WordRepositoryImpl(this.database);

  @override
  Future<List<Word>> allByGroup(EntityId groupId) {
    if (groupId.isEmpty) {
      return Future.value([]);
    }

    return database
        .allWordsByGroupId(groupId.valueOrThrow())
        .map(WordSqlMapper.from)
        .get();
  }

  @override
  Future<int> create({
    required EntityId group,
    required String origin,
    required String translation,
  }) {
    final now = DateTime.now();

    return database.managers.words.create(
      (o) => o(
        groupId: group.valueOrThrow(),
        created: now,
        origin: origin,
        translation: translation,
      ),
    );
  }

  @override
  Future createAll({required EntityId groupId, required List<WordDraft> drafts}) {
    final now = DateTime.now();

    int id = groupId.valueOrThrow();

    return database.managers.words.bulkCreate(
      (o) => List.generate(drafts.length, (index) {
        final draft = drafts[index];

        return o(
          groupId: id,
          created: now,
          origin: draft.origin,
          translation: draft.translation,
        );
      }),
    );
  }

  @override
  Future delete(EntityId id) {
    if (id.isEmpty) {
      return Future.value();
    }

    return database.managers.words
        .filter((f) => f.id.equals(id.valueOrThrow()))
        .delete();
  }
}
