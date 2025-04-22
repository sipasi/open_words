import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class WordGroupSqlMapper {
  static WordGroup from(QueryRow row) {
    return WordGroup(
      id: Id.exist(row.read('id')),
      folderId: Id.emptyIfNull(row.readNullable('folder_id')),
      created: row.read('created'),
      modified: row.read('modified'),
      name: row.read('name'),
      words: row.readNullable<int>('words_count') ?? 0,
      origin: LanguageInfo(
        code: row.data['language_origin_code'],
        name: row.data['language_origin_name'],
        native: row.data['language_origin_native'],
      ),
      translation: LanguageInfo(
        code: row.data['language_translation_code'],
        name: row.data['language_translation_name'],
        native: row.data['language_translation_native'],
      ),
    );
  }

  static Insertable<DriftWordGroup> toCreate({
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
      languageOriginCode: origin.code,
      languageOriginName: origin.name,
      languageOriginNative: origin.native,
      languageTranslationCode: translation.code,
      languageTranslationName: translation.name,
      languageTranslationNative: translation.native,
    );
  }

  static Insertable<DriftWordGroup> toUpdate({
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
      languageOriginCode: Value.absentIfNull(origin?.code),
      languageOriginName: Value.absentIfNull(origin?.name),
      languageOriginNative: Value.absentIfNull(origin?.native),
      languageTranslationCode: Value.absentIfNull(translation?.code),
      languageTranslationName: Value.absentIfNull(translation?.name),
      languageTranslationNative: Value.absentIfNull(translation?.native),
    );
  }
}
