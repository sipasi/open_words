import 'package:drift/drift.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

extension WordStatisticsQuery on AppDriftDatabase {
  Selectable<QueryRow> getWithFewerAttempts(String word, int count) {
    return customSelect(
      'SELECT w.*, COALESCE(s.correct, 0) + COALESCE(s.incorrect, 0) AS attempt_count '
      'FROM words AS w '
      'LEFT JOIN word_statistics s ON s.word = w.origin '
      'WHERE w.origin = ?1 '
      'ORDER BY attempt_count ASC '
      'LIMIT ?2',
      variables: [Variable<String>(word), Variable<int>(count)],
      readsFrom: {words, wordStatistics},
    );
  }
}
