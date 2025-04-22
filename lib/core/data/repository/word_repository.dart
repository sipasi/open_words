import 'package:drift/drift.dart';
import 'package:open_words/core/data/draft/word_draft.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/repository/mappers/word_sql_mapper.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class WordRepository {
  Future<List<Word>> allByGroup(Id group);

  Future<int> create({
    required Id group,
    required String origin,
    required String translation,
  });

  Future createAll({required Id groupId, required List<WordDraft> drafts});
}

class WordRepositoryImpl extends WordRepository {
  final AppDriftDatabase database;

  WordRepositoryImpl(this.database);

  @override
  Future<List<Word>> allByGroup(Id groupId) {
    return database.allByGroupQuery(groupId).map(WordSqlMapper.from).get();
  }

  @override
  Future<int> create({
    required Id group,
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
  Future createAll({required Id groupId, required List<WordDraft> drafts}) {
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
}

extension _Queries on AppDriftDatabase {
  Selectable<QueryRow> allByGroupQuery(Id groupId) {
    return customSelect(
      _query(where: 'w.group_id = ?'),
      variables: [Variable.withInt(groupId.valueOrThrow())],
    );
  }

  static String _query({String? where}) {
    const template =
        'SELECT w.* '
        'FROM words w ';

    return where == null ? '$template;' : '$template WHERE $where;';
  }
}
