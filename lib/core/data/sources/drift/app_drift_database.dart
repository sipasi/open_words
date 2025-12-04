import 'package:drift/drift.dart';
import 'package:open_words/core/data/sources/drift/connections/connection.dart';
import 'package:open_words/core/data/sources/drift/synonym_antonym_converter.dart';

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
  static const String _name = 'open-words-drift-database';

  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDriftDatabase([QueryExecutor? executor])
    : super(executor ?? createExecutor(_name));

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
}
