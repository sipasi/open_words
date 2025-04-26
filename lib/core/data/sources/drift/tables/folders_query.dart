import 'package:drift/drift.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

extension DriftFoldersQuery on AppDriftDatabase {
  Selectable<QueryRow> oneFolderById(int id) {
    return customSelect(
      'SELECT f.* FROM folders AS f WHERE f.id = ?1 ORDER BY f.name',
      variables: [Variable<int>(id)],
      readsFrom: {folders},
    );
  }

  Selectable<QueryRow> oneFolderByName(String name) {
    return customSelect(
      'SELECT f.* FROM folders AS f WHERE f.name = ?1 ORDER BY f.name',
      variables: [Variable<String>(name)],
      readsFrom: {folders},
    );
  }

  Selectable<QueryRow> allFolders() {
    return customSelect(
      'SELECT f.* FROM folders AS f ORDER BY f.name',
      variables: [],
      readsFrom: {folders},
    );
  }

  Selectable<QueryRow> allFoldersByParent(int? parentId) {
    return customSelect(
      'SELECT f.* FROM folders AS f WHERE f.parent_id = ?1 ORDER BY f.name',
      variables: [Variable<int>(parentId)],
      readsFrom: {folders},
    );
  }

  Selectable<QueryRow> allFoldersByRoot() {
    return customSelect(
      'SELECT f.* FROM folders AS f WHERE f.parent_id IS NULL ORDER BY f.name',
      variables: [],
      readsFrom: {folders},
    );
  }

  Selectable<QueryRow> onePathById(int folderId) {
    return customSelect(
      'WITH RECURSIVE FolderPath (id, parent_id, name, full_path) AS (SELECT id, parent_id, name, name AS full_path FROM folders WHERE id = ?1 UNION ALL SELECT f.id, f.parent_id, f.name, f.name || \'/\' || fp.full_path FROM folders AS f JOIN FolderPath AS fp ON fp.parent_id = f.id) SELECT * FROM FolderPath',
      variables: [Variable<int>(folderId)],
      readsFrom: {folders},
    );
  }

  Selectable<QueryRow> allPath() {
    return customSelect(
      'WITH RECURSIVE FolderPath (id, parent_id, name, full_path) AS (SELECT id, parent_id, name, name AS full_path FROM folders WHERE parent_id IS NULL UNION ALL SELECT f.id, f.parent_id, f.name, fp.full_path || \'/\' || f.name AS full_path FROM folders AS f JOIN FolderPath AS fp ON f.parent_id = fp.id) SELECT * FROM FolderPath ORDER BY full_path',
      variables: [],
      readsFrom: {folders},
    );
  }

  Selectable<QueryRow> allMovablePath(int? id) {
    return customSelect(
      'WITH RECURSIVE FolderPath (id, parent_id, name, full_path) AS (SELECT id, parent_id, name, name AS full_path FROM folders WHERE parent_id IS NULL AND id != ?1 UNION ALL SELECT f.id, f.parent_id, f.name, fp.full_path || \'/\' || f.name AS full_path FROM folders AS f JOIN FolderPath AS fp ON f.parent_id = fp.id WHERE f.id != ?1 AND f.parent_id != ?1) SELECT * FROM FolderPath ORDER BY full_path',
      variables: [Variable<int>(id)],
      readsFrom: {folders},
    );
  }
}
