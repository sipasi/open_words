part of '../app_drift_database.dart';

@TableIndex(name: 'metadata_word_index', columns: {#word})
@DataClassName('DriftWordMetadata')
class WordMetadatas extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get word => text()();

  TextColumn get etymology => text()();
}

@DataClassName('DriftPhonetic')
class Phonetics extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get metadataId =>
      integer().references(WordMetadatas, #id, onDelete: KeyAction.cascade)();

  TextColumn get value => text()();
  TextColumn get audio => text()();
}

@DataClassName('DriftMeaning')
class Meanings extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get metadataId =>
      integer().references(WordMetadatas, #id, onDelete: KeyAction.cascade)();

  TextColumn get partOfSpeech => text()();

  TextColumn get synonyms => text().map(const SynonymAntonymConverter())();
  TextColumn get antonyms => text().map(const SynonymAntonymConverter())();
}

@DataClassName('DriftDefinition')
class Definitions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get meaningId =>
      integer().references(Meanings, #id, onDelete: KeyAction.cascade)();

  TextColumn get value => text()();
  TextColumn get example => text()();
}
