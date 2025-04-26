import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/mappers/word_group_sql_mapper.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';
import 'package:open_words/core/data/sources/drift/tables/word_groups_query.dart';

sealed class WordGroupRepository {
  Future<List<WordGroup>> all();
  Future<List<WordGroup>> allByFolder(Id folderId);
  Future<WordGroup?> oneById(Id id);

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
    return database.allGroups().map(WordGroupSqlMapper.from).get();
  }

  @override
  Future<List<WordGroup>> allByFolder(Id folderId) {
    if (folderId.isEmpty) {
      return database
          .allGroupsByFolderRoot()
          .map(WordGroupSqlMapper.from)
          .get();
    }

    return database
        .allGroupsByFolder(folderId.valueOrThrow())
        .map(WordGroupSqlMapper.from)
        .get();
  }

  @override
  Future<WordGroup?> oneById(Id id) {
    if (id.isEmpty) {
      return Future.value();
    }

    return database
        .oneGroupById(id.valueOrThrow())
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

    final entity = await oneById(Id.exist(id));

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

    final entity = await oneById(id);

    return entity!;
  }

  @override
  Future delete(Id id) {
    return database.managers.wordGroups
        .filter((f) => f.id.equals(id.valueOrNull()))
        .delete();
  }
}
