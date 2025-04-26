import 'package:drift/drift.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

extension DriftWordQuery on AppDriftDatabase {
  Selectable<QueryRow> allWordsByGroupId(int groupId) {
    return customSelect(
      'SELECT w.* '
      'FROM words w '
      'WHERE w.group_id = ?1 '
      'ORDER BY w.created DESC',
      variables: [Variable.withInt(groupId)],
      readsFrom: {words},
    );
  }
}
