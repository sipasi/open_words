import 'package:drift/drift.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

extension DriftWordGroupsQuery on AppDriftDatabase {
  Selectable<QueryRow> oneGroupById(int id) {
    return customSelect(
      'SELECT g.*, COUNT(w.id) words_count '
      'FROM word_groups g '
      'LEFT JOIN words w ON w.group_id = g.id '
      'WHERE g.id = ?1 '
      'GROUP BY g.id '
      'ORDER BY g.name',
      variables: [Variable.withInt(id)],
      readsFrom: {wordGroups, words},
    );
  }

  Selectable<QueryRow> allGroups() {
    return customSelect(
      'SELECT g.*, COUNT(w.id) words_count '
      'FROM word_groups g '
      'LEFT JOIN words AS w ON w.group_id = g.id '
      'GROUP BY g.id '
      'ORDER BY g.name',
      readsFrom: {wordGroups, words},
    );
  }

  Selectable<QueryRow> allGroupsByFolderRoot() {
    return customSelect(
      'SELECT g.*, COUNT(w.id) words_count '
      'FROM word_groups g '
      'LEFT JOIN words w ON w.group_id = g.id '
      'WHERE g.folder_id IS NULL '
      'GROUP BY g.id '
      'ORDER BY g.name',
      readsFrom: {wordGroups, words},
    );
  }

  Selectable<QueryRow> allGroupsByFolder(int folderId) {
    return customSelect(
      'SELECT g.*, COUNT(w.id) words_count '
      'FROM word_groups g '
      'LEFT JOIN words w ON w.group_id = g.id '
      'WHERE g.folder_id = ?1 '
      'GROUP BY g.id '
      'ORDER BY g.name',
      variables: [Variable.withInt(folderId)],
      readsFrom: {wordGroups, words},
    );
  }
}
