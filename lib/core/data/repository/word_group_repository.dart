import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/mappers/word_group_sql_mapper.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class WordGroupRepository {
  Future<List<WordGroup>> all();
  Future<List<WordGroup>> allByFolder(Id folderId);
  Future<WordGroup?> byId(Id id);

  Future delete(Id id);

  Future<WordGroup> create({
    required Id folderId,
    required String name,
    required LanguageInfo origin,
    required LanguageInfo translation,
  });

  Future<WordGroup> update({
    required Id id,
    Id? folderId,
    String? name,
    LanguageInfo? origin,
    LanguageInfo? translation,
  });
}

class WordGroupRepositoryImpl extends WordGroupRepository {
  final AppDriftDatabase database;

  WordGroupRepositoryImpl(this.database);

  @override
  Future<List<WordGroup>> all() {
    return database.allQuery().map(WordGroupSqlMapper.from).get();
  }

  @override
  Future<List<WordGroup>> allByFolder(Id folderId) {
    return database
        .allByFolderQuery(folderId)
        .map(WordGroupSqlMapper.from)
        .get();
  }

  @override
  Future<WordGroup?> byId(Id id) {
    return database
        .byIdQuery(id)
        .map(WordGroupSqlMapper.from)
        .getSingleOrNull();
  }

  @override
  Future<WordGroup> create({
    required Id folderId,
    required String name,
    required LanguageInfo origin,
    required LanguageInfo translation,
  }) async {
    final id = await database
        .into(database.wordGroups)
        .insert(
          WordGroupSqlMapper.toCreate(
            folderId: folderId,
            name: name,
            origin: origin,
            translation: translation,
          ),
        );

    final entity = await byId(Id.exist(id));

    return entity!;
  }

  @override
  Future<WordGroup> update({
    required Id id,
    Id? folderId,
    String? name,
    LanguageInfo? origin,
    LanguageInfo? translation,
  }) async {
    await database.managers.wordGroups
        .filter((f) => f.id.equals(id.valueOrNull()))
        .update(
          (_) => WordGroupSqlMapper.toUpdate(
            folderId: folderId,
            name: name,
            origin: origin,
            translation: translation,
          ),
        );

    final entity = await byId(id);

    return entity!;
  }

  @override
  Future delete(Id id) {
    return database.managers.wordGroups
        .filter((f) => f.id.equals(id.valueOrNull()))
        .delete();
  }
}

extension _Queries on AppDriftDatabase {
  Selectable<QueryRow> allQuery() {
    return customSelect(_query());
  }

  Selectable<QueryRow> allByFolderQuery(Id folderId) {
    if (folderId.isEmpty) {
      return customSelect(_query(where: 'g.folder_id IS NULL'));
    }

    return customSelect(
      _query(where: 'g.folder_id = ?'),
      variables: [Variable.withInt(folderId.valueOrThrow())],
    );
  }

  Selectable<QueryRow> byIdQuery(Id id) {
    return customSelect(
      _query(where: 'g.id = ?'),
      variables: [Variable.withInt(id.valueOrThrow())],
    );
  }

  static String _query({String? where}) {
    const template =
        'SELECT g.*, COUNT(w.id) AS words_count '
        'FROM word_groups g '
        'LEFT JOIN words w ON w.group_id = g.id ';

    return where == null
        ? '$template GROUP BY g.id ORDER BY g.name;'
        : '$template WHERE $where GROUP BY g.id ORDER BY g.name;';
  }
}
