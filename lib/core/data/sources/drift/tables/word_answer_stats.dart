part of '../app_drift_database.dart';

@TableIndex(name: 'index_word', columns: {#word})
@TableIndex(name: 'index_correct', columns: {#correct})
@TableIndex(name: 'index_incorrect', columns: {#incorrect})
@TableIndex(
  name: 'index_word_correct_incorrect',
  columns: {#word, #correct, #incorrect},
)
@DataClassName('DriftWordAnswerStats')
class WordAnswerStats extends Table {
  TextColumn get word => text().unique()();

  IntColumn get correct => integer()();
  IntColumn get incorrect => integer()();
}
