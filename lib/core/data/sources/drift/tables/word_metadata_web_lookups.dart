part of '../app_drift_database.dart';

@TableIndex(name: 'web_lookups_word', columns: {#word})
@DataClassName('DriftWordMetadataWebLookup')
class WordMetadataWebLookups extends Table {
  TextColumn get word => text()();

  DateTimeColumn get firstAttemp => dateTime()();
  DateTimeColumn get lastAttemp => dateTime()();

  IntColumn get attemps => integer()();
}
