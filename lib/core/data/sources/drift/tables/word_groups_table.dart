part of '../app_drift_database.dart';

@TableIndex(name: 'group_name', columns: {#name})
@TableIndex(name: 'group_created', columns: {#created})
@DataClassName('DriftWordGroup')
class WordGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get folderId => integer().nullable().references(
    Folders,
    #id,
    onDelete: KeyAction.cascade,
  )();

  DateTimeColumn get created => dateTime()();
  DateTimeColumn get modified => dateTime()();

  TextColumn get name => text()();

  TextColumn get originCode => text()();

  TextColumn get translationCode => text()();
}
