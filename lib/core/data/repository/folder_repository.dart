import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/folder/folder.dart';
import 'package:open_words/core/data/entities/folder/folder_path.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/repository/mappers/folder_sql_mapper.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class FolderRepository {
  Future<List<Folder>> all();
  Future<List<Folder>> allByParent(Id parent);

  Future<List<FolderPath>> allPath();
  Future<List<FolderPath>> allMovedPathFor(Id id);
  Future<FolderPath?> onePath(Id id);

  Future<Folder?> byId(Id id);
  Future<Folder?> byName(String name);

  Future delete(Id id);

  Future<Folder> create({required Id parentId, required String name});
  Future<Folder> update({required Id id, Id parentId, String name});
}

class FolderRepositoryImpl extends FolderRepository {
  final AppDriftDatabase database;

  FolderRepositoryImpl(this.database);

  @override
  Future<List<Folder>> all() {
    return database.allQuery().map(FolderSqlMapper.from).get();
  }

  @override
  Future<List<Folder>> allByParent(Id parentId) {
    return database.allByParentQuery(parentId).map(FolderSqlMapper.from).get();
  }

  @override
  Future<List<FolderPath>> allPath() {
    return database.allPathQuery().map(FolderSqlMapper.folderPath).get();
  }

  @override
  Future<List<FolderPath>> allMovedPathFor(Id id) {
    return database
        .allMovedPathByQuery(id)
        .map(FolderSqlMapper.folderPath)
        .get();
  }

  @override
  Future<FolderPath?> onePath(Id id) {
    return database
        .pathQuery(id)
        .map(FolderSqlMapper.folderPath)
        .getSingleOrNull();
  }

  @override
  Future<Folder?> byId(Id id) {
    if (id.isEmpty) {
      return Future.value();
    }

    return database.byIdQuery(id).map(FolderSqlMapper.from).getSingleOrNull();
  }

  @override
  Future<Folder?> byName(String name) {
    return database
        .byNameQuery(name)
        .map(FolderSqlMapper.from)
        .getSingleOrNull();
  }

  @override
  Future<Folder> create({Id? parentId, required String name}) async {
    final id = await database
        .into(database.folders)
        .insert(FolderSqlMapper.toCreate(parentId: parentId, name: name));

    final entity = await byId(Id.exist(id));

    return entity!;
  }

  @override
  Future<Folder> update({required Id id, Id? parentId, String? name}) async {
    if (parentId != null) {}

    await database.managers.folders
        .filter((f) => f.id.equals(id.valueOrNull()))
        .update(
          (_) => FolderSqlMapper.toUpdate(parentId: parentId, name: name),
        );

    final entity = await byId(id);

    return entity!;
  }

  @override
  Future delete(Id id) {
    return database.managers.folders
        .filter((f) => f.id.equals(id.valueOrNull()))
        .delete();
  }
}

extension _Queries on AppDriftDatabase {
  Selectable<QueryRow> allQuery() {
    return customSelect(_query());
  }

  Selectable<QueryRow> allByParentQuery(Id parentId) {
    if (parentId.isEmpty) {
      return customSelect(_query(where: 'f.parent_id IS NULL'));
    }

    return customSelect(
      _query(where: 'f.parent_id = ?'),
      variables: [Variable.withInt(parentId.valueOrThrow())],
    );
  }

  Selectable<QueryRow> allPathQuery() {
    return customSelect(_allPathQuery());
  }

  Selectable<QueryRow> allMovedPathByQuery(Id id) {
    return customSelect(_allMovedPathByQuery(id));
  }

  Selectable<QueryRow> pathQuery(Id id) {
    return customSelect(_pathQuery(id));
  }

  Selectable<QueryRow> byIdQuery(Id id) {
    return customSelect(
      _query(where: 'f.id = ?'),
      variables: [Variable.withInt(id.valueOrThrow())],
    );
  }

  Selectable<QueryRow> byNameQuery(String name) {
    return customSelect(
      _query(where: 'f.name = ?'),
      variables: [Variable.withString(name)],
    );
  }

  static String _query({String? where}) {
    const template =
        'SELECT f.* '
        'FROM folders f ';

    return where == null
        ? '$template ORDER BY f.name;'
        : '$template WHERE $where ORDER BY f.name;';
  }

  static String _allPathQuery() {
    return '''
WITH RECURSIVE FolderPath(id, parent_id, name, full_path) AS (
    -- Base case: root folders
    SELECT
        id,
        parent_id,
        name,
        name AS full_path
    FROM folders
    WHERE parent_id IS NULL

    UNION ALL

    -- Recursive step: append name to parent's full path
    SELECT
        f.id,
        f.parent_id,
        f.name,
        fp.full_path || '/' || f.name AS full_path
    FROM folders f
    JOIN FolderPath fp ON f.parent_id = fp.id
)
SELECT * FROM FolderPath;
''';
  }

  static String _allMovedPathByQuery(Id id) {
    int? idValue = id.valueOrNull();

    return '''
WITH RECURSIVE FolderPath(id, parent_id, name, full_path) AS (
    -- Base case: root folders
    SELECT
        id,
        parent_id,
        name,
        name AS full_path
    FROM folders
    WHERE parent_id IS NULL

    UNION ALL

    -- Recursive step: append name to parent's full path
    SELECT
        f.id,
        f.parent_id,
        f.name,
        fp.full_path || '/' || f.name AS full_path
    FROM folders f
    JOIN FolderPath fp ON f.parent_id = fp.id
    WHERE f.id != $idValue
)
SELECT * FROM FolderPath;
''';
  }

  static String _pathQuery(Id id) {
    return '''
WITH RECURSIVE FolderPath(id, parent_id, name, full_path) AS (
    -- Start from the target folder
    SELECT
        id,
        parent_id,
        name,
        name AS full_path
    FROM folders
    WHERE id = ${id.valueOrNull() ?? -1}

    UNION ALL

    -- Go upward toward the root
    SELECT
        f.id,
        f.parent_id,
        f.name,
        f.name || '/' || fp.full_path
    FROM folders f
    JOIN FolderPath fp ON fp.parent_id = f.id
)
SELECT * FROM FolderPath;
''';
  }
}
