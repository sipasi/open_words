import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/sources/drift/language_info_converter.dart';
import 'package:open_words/core/data/sources/drift/synonym_antonym_converter.dart';
import 'package:path_provider/path_provider.dart';

part 'app_drift_database.g.dart';

@DataClassName('DriftWord')
class Words extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get groupId =>
      integer().references(WordGroups, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get created => dateTime()();

  TextColumn get origin => text()();
  TextColumn get translation => text()();
}

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

  TextColumn get origin => text().map(const LanguageInfoConverter())();
  TextColumn get translation => text().map(const LanguageInfoConverter())();
}

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

@TableIndex(name: 'word_index', columns: {#word})
@DataClassName('DriftWordMetadata')
class WordMetadatas extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get word => text()();
}

@DataClassName('DriftPhonetic')
class Phonetics extends Table {
  IntColumn get metadataId =>
      integer().nullable().references(
        WordMetadatas,
        #id,
        onDelete: KeyAction.cascade,
      )();

  TextColumn get value => text()();
  TextColumn get audio => text().nullable()();
}

@DataClassName('DriftMeaning')
class Meanings extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get metadataId =>
      integer().nullable().references(
        WordMetadatas,
        #id,
        onDelete: KeyAction.cascade,
      )();

  TextColumn get partOfSpeech => text()();

  TextColumn get synonyms => text().map(const SynonymAntonymConverter())();
  TextColumn get antonyms => text().map(const SynonymAntonymConverter())();
}

@DataClassName('DriftDefinition')
class Definitions extends Table {
  IntColumn get meaningId =>
      integer().nullable().references(
        Meanings,
        #id,
        onDelete: KeyAction.cascade,
      )();

  TextColumn get value => text()();
  TextColumn get example => text()();
}

@DriftDatabase(tables: [Folders, WordGroups, Words])
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
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
