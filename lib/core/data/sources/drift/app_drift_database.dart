import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:open_words/core/data/sources/drift/synonym_antonym_converter.dart';
import 'package:path_provider/path_provider.dart';

part 'app_drift_database.g.dart';
part 'tables/folders_table.dart';
part 'tables/word_groups_table.dart';
part 'tables/word_metadata_web_lookups.dart';
part 'tables/word_metadatas_table.dart';
part 'tables/word_statistics.dart';
part 'tables/words_table.dart';

@DriftDatabase(
  tables: [
    Folders,
    WordGroups,
    Words,
    WordStatistics,
    WordMetadatas,
    WordMetadataWebLookups,
    Phonetics,
    Meanings,
    Definitions,
  ],
)
class AppDriftDatabase extends _$AppDriftDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDriftDatabase([QueryExecutor? executor])
    : super(executor ?? _getConnection());

  static const String _name = 'open-words-drift-database';

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  static QueryExecutor _getConnection() {
    return kIsWeb || kIsWasm ? _openConnectionOnWeb() : _openConnection();
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: _name,
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  static DatabaseConnection _openConnectionOnWeb() {
    return DatabaseConnection.delayed(
      Future(() async {
        final result = await WasmDatabase.open(
          databaseName: _name,
          sqlite3Uri: Uri.parse('sqlite3.wasm'),
          driftWorkerUri: Uri.parse('drift_worker.dart.js'),
        );

        if (result.missingFeatures.isNotEmpty) {
          // Depending how central local persistence is to your app, you may want
          // to show a warning to the user if only unrealiable implemetentations
          // are available.
          Logger().e(
            'Using ${result.chosenImplementation} due to missing browser\n'
            '  features: ${result.missingFeatures}',
          );
        }

        return result.resolvedExecutor;
      }),
    );
  }
}
