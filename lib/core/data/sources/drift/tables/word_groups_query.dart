import 'package:drift/drift.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

extension DriftWordGroupsQuery on AppDriftDatabase {
  Selectable<QueryRow> existByName(String name) {
    return customSelect(
      'SELECT g.name '
      'FROM word_groups g '
      'WHERE g.name = ?1',
      variables: [Variable.withString(name)],
      readsFrom: {wordGroups},
    );
  }

  Selectable<QueryRow> existByNameIn(String name, int folderId) {
    return customSelect(
      'SELECT g.name '
      'FROM word_groups g '
      'WHERE g.name = ?1 '
      'AND g.folder_id = ?2',
      variables: [Variable.withString(name), Variable.withInt(folderId)],
      readsFrom: {wordGroups},
    );
  }

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

  Selectable<QueryRow> allUniqueLanguages() {
    return customSelect(
      'SELECT g.origin_code AS origin_code '
      'FROM word_groups g '
      'UNION '
      'SELECT g.translation_code AS origin_code '
      'FROM word_groups g '
      'ORDER BY g.origin_code',
      readsFrom: {wordGroups},
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
