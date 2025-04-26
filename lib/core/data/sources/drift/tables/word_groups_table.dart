part of '../app_drift_database.dart';

@TableIndex(name: 'group_created', columns: {#created})
@TableIndex(name: 'group_name', columns: {#name})
@TableIndex(name: 'group_language_origin_code', columns: {#languageOriginCode})
@TableIndex(
  name: 'group_language_translation_code',
  columns: {#languageTranslationCode},
)
@TableIndex(
  name: 'group_language_origin_translation_code',
  columns: {#languageOriginCode, #languageTranslationCode},
)
@DataClassName('DriftWordGroup')
class WordGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get folderId =>
      integer().nullable().references(
        Folders,
        #id,
        onDelete: KeyAction.cascade,
      )();

  DateTimeColumn get created => dateTime()();
  DateTimeColumn get modified => dateTime()();

  TextColumn get name => text()();

  TextColumn get languageOriginCode => text()();
  TextColumn get languageOriginName => text()();
  TextColumn get languageOriginNative => text()();

  TextColumn get languageTranslationCode => text()();
  TextColumn get languageTranslationName => text()();
  TextColumn get languageTranslationNative => text()();
}
