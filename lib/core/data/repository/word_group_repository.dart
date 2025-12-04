import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/mappers/language_info_sql_mapper.dart';
import 'package:open_words/core/data/repository/mappers/word_group_sql_mapper.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';
import 'package:open_words/core/data/sources/drift/tables/word_groups_query.dart';
import 'package:open_words/core/services/language/language_info_service.dart';
import 'package:open_words/core/services/logger/app_logger.dart';

abstract class WordGroupRepository {
  Future<bool> existByName(String originName);
  Future<bool> existByNameIn(String originName, Id folder);

  Future<List<WordGroup>> all();
  Future<List<WordGroup>> allByFolder(Id folderId);

  Future<WordGroup?> oneById(Id id);

  Future<List<LanguageInfo>> allUniqueLanguages();

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
  final WordGroupSqlMapper groupMapper;
  final LanguageInfoSqlMapper languageMapper;

  WordGroupRepositoryImpl(
    this.database, {
    required AppLogger logger,
    required LanguageInfoService languages,
  }) : groupMapper = WordGroupSqlMapper(
         logger: logger,
         languages: languages,
       ),
       languageMapper = LanguageInfoSqlMapper(
         logger: logger,
         languages: languages,
       );

  @override
  Future<bool> existByName(String name) async {
    return (await database.existByName(name).getSingleOrNull()) != null;
  }

  @override
  Future<bool> existByNameIn(String name, Id folder) async {
    int? id = folder.valueOrNull();

    if (id == null) {
      return false;
    }

    return (await database.existByNameIn(name, id).getSingleOrNull()) != null;
  }

  @override
  Future<List<WordGroup>> all() {
    return database.allGroups().map(groupMapper.from).get();
  }

  @override
  Future<List<WordGroup>> allByFolder(Id folderId) {
    if (folderId.isEmpty) {
      return database.allGroupsByFolderRoot().map(groupMapper.from).get();
    }

    return database
        .allGroupsByFolder(folderId.valueOrThrow())
        .map(groupMapper.from)
        .get();
  }

  @override
  Future<WordGroup?> oneById(Id id) {
    if (id.isEmpty) {
      return Future.value();
    }

    return database
        .oneGroupById(id.valueOrThrow())
        .map(groupMapper.from)
        .getSingleOrNull();
  }

  @override
  Future<List<LanguageInfo>> allUniqueLanguages() async {
    return database
        .allUniqueLanguages()
        .map(languageMapper.originOrTranslationFrom)
        .get();
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
          groupMapper.toCreate(
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
          (_) => groupMapper.toUpdate(
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
