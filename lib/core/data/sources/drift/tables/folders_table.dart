part of '../app_drift_database.dart';

@TableIndex(name: 'folder_created', columns: {#created})
@TableIndex(name: 'folder_name', columns: {#name})
@DataClassName('DriftFolder')
class Folders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId =>
      integer().nullable().references(
        Folders,
        #id,
        onDelete: KeyAction.cascade,
      )();

  DateTimeColumn get created => dateTime()();

  TextColumn get name => text()();
}
