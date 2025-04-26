import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:open_words/core/data/sources/drift/synonym_antonym_converter.dart';
import 'package:path_provider/path_provider.dart';

part 'app_drift_database.g.dart';
part 'tables/folders_table.dart';
part 'tables/word_groups_table.dart';
part 'tables/word_metadata_web_lookups.dart';
part 'tables/word_metadatas_table.dart';
part 'tables/word_repeats.dart';
part 'tables/words_table.dart';

@DriftDatabase(
  tables: [
    Folders,
    WordGroups,
    Words,
    WordRepeats,
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
    : super(executor ?? _openConnection());

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

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'open-words-drift-database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
