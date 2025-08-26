import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/mappers/language_info_sql_mapper.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';
import 'package:open_words/core/services/language/language_info_service.dart';
import 'package:open_words/core/services/logger/app_logger.dart';

final class WordGroupSqlMapper {
  final LanguageInfoSqlMapper languageMapper;

  WordGroupSqlMapper({
    required AppLogger logger,
    required LanguageInfoService languages,
  }) : languageMapper = LanguageInfoSqlMapper(
         logger: logger,
         languages: languages,
       );

  WordGroup from(QueryRow row) {
    return WordGroup(
      id: Id.exist(row.read('id')),
      folderId: Id.emptyIfNull(row.readNullable('folder_id')),
      created: row.read('created'),
      modified: row.read('modified'),
      name: row.read('name'),
      words: row.readNullable<int>('words_count') ?? 0,
      origin: languageMapper.originFrom(row),
      translation: languageMapper.translationFrom(row),
    );
  }

  Insertable<DriftWordGroup> toCreate({
    required Id folderId,
    required String name,
    required LanguageInfo origin,
    required LanguageInfo translation,
  }) {
    final now = DateTime.now();

    return WordGroupsCompanion.insert(
      folderId: Value.absentIfNull(folderId.valueOrNull()),
      created: now,
      modified: now,
      name: name,
      originCode: origin.code,
      translationCode: translation.code,
    );
  }

  Insertable<DriftWordGroup> toUpdate({
    Id? folderId,
    String? name,
    LanguageInfo? origin,
    LanguageInfo? translation,
    int? words,
  }) {
    final now = DateTime.now();

    return WordGroupsCompanion(
      folderId: Value.absentIfNull(folderId?.valueOrNull()),
      modified: Value(now),
      name: Value.absentIfNull(name),
      originCode: Value.absentIfNull(origin?.code),
      translationCode: Value.absentIfNull(translation?.code),
    );
  }
}
