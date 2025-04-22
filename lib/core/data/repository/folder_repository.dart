import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/folder/folder.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/repository/mappers/folder_sql_mapper.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class FolderRepository {
  Future<List<Folder>> all();
  Future<List<Folder>> allByParent(Id parent);

  Future<Folder?> byId(Id id);
  Future<Folder?> byName(String name);

  Future<Folder> create({required Id parentId, required String name});
  Future<Folder> update({
    required Id id,
    required Id parentId,
    required String name,
  });
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
  Future<Folder?> byId(Id id) {
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
    final now = DateTime.now();

    final id = await database
        .into(database.folders)
        .insert(FolderSqlMapper.toCreate(parentId: parentId, name: name));

    final entity = await byId(Id.exist(id));

    return entity!;
  }

  @override
  Future<Folder> update({required Id id, Id? parentId, String? name}) async {
    await database.managers.folders
        .filter((f) => f.id.equals(id.valueOrNull()))
        .update(
          (_) => FolderSqlMapper.toUpdate(parentId: parentId, name: name),
        );

    final entity = await byId(id);

    return entity!;
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

    return where == null ? '$template;' : '$template WHERE $where;';
  }
}
