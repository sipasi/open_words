part of '../app_drift_database.dart';

@TableIndex(name: 'word_created', columns: {#created})
@DataClassName('DriftWord')
class Words extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get groupId =>
      integer().references(WordGroups, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get created => dateTime()();

  TextColumn get origin => text()();
  TextColumn get translation => text()();
}
