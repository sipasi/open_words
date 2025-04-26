part of '../app_drift_database.dart';

@DataClassName('DriftWordMetadataWebLookup')
class WordMetadataWebLookups extends Table {
  TextColumn get word => text()();

  DateTimeColumn get attemp => dateTime()();

  IntColumn get count => integer()();
}
