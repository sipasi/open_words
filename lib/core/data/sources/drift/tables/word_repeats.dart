part of '../app_drift_database.dart';

@TableIndex(name: 'word_repeats_word', columns: {#word})
@TableIndex(name: 'word_repeats_repeat', columns: {#repeat})
@TableIndex(name: 'word_repeats_count', columns: {#count})
@TableIndex(name: 'word_repeats_word_repeat', columns: {#word, #repeat})
@TableIndex(name: 'word_repeats_count_repeat', columns: {#count, #repeat})
@DataClassName('DriftWordRepeats')
class WordRepeats extends Table {
  TextColumn get word => text()();

  DateTimeColumn get repeat => dateTime()();

  IntColumn get count => integer()();
}
