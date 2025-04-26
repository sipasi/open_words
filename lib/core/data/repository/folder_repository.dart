import 'package:open_words/core/data/entities/folder/folder.dart';
import 'package:open_words/core/data/entities/folder/folder_path.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/repository/mappers/folder_sql_mapper.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';
import 'package:open_words/core/data/sources/drift/tables/folders_query.dart';

sealed class FolderRepository {
  Future<List<Folder>> all();
  Future<List<Folder>> allByParent(Id parent);

  Future<Folder?> oneById(Id id);
  Future<Folder?> oneByName(String name);

  Future delete(Id id);

  Future<Folder> create({required Id parentId, required String name});
  Future<Folder> update({required Id id, Id parentId, String name});

  Future<List<FolderPath>> allPath();
  Future<List<FolderPath>> allMovablePathBy(Id id);
  Future<FolderPath?> onePath(Id id);
}

class FolderRepositoryImpl extends FolderRepository {
  final AppDriftDatabase database;

  FolderRepositoryImpl(this.database);

  @override
  Future<List<Folder>> all() {
    return database.allFolders().map(FolderSqlMapper.from).get();
  }

  @override
  Future<List<Folder>> allByParent(Id parentId) {
    if (parentId.isEmpty) {
      return database.allFoldersByRoot().map(FolderSqlMapper.from).get();
    }

    return database
        .allFoldersByParent(parentId.valueOrThrow())
        .map(FolderSqlMapper.from)
        .get();
  }

  @override
  Future<Folder?> oneById(Id id) {
    if (id.isEmpty) {
      return Future.value();
    }

    return database
        .oneFolderById(id.valueOrThrow())
        .map(FolderSqlMapper.from)
        .getSingleOrNull();
  }

  @override
  Future<Folder?> oneByName(String name) {
    return database
        .oneFolderByName(name)
        .map(FolderSqlMapper.from)
        .getSingleOrNull();
  }

  @override
  Future<Folder> create({Id? parentId, required String name}) async {
    final id = await database
        .into(database.folders)
        .insert(FolderSqlMapper.toCreate(parentId: parentId, name: name));

    final entity = await oneById(Id.exist(id));

    return entity!;
  }

  @override
  Future<Folder> update({required Id id, Id? parentId, String? name}) async {
    if (id.isEmpty) {
      throw '[FolderRepositoryImpl.update] update not existed entity';
    }

    await database.managers.folders
        .filter((f) => f.id.equals(id.valueOrNull()))
        .update(
          (_) => FolderSqlMapper.toUpdate(parentId: parentId, name: name),
        );

    final entity = await oneById(id);

    return entity!;
  }

  @override
  Future delete(Id id) {
    return database.managers.folders
        .filter((f) => f.id.equals(id.valueOrNull()))
        .delete();
  }

  @override
  Future<List<FolderPath>> allPath() {
    return database.allPath().map(FolderSqlMapper.folderPath).get();
  }

  @override
  Future<List<FolderPath>> allMovablePathBy(Id id) {
    if (id.isEmpty) {
      return Future.value([]);
    }

    return database
        .allMovablePath(id.valueOrThrow())
        .map(FolderSqlMapper.folderPath)
        .get();
  }

  @override
  Future<FolderPath?> onePath(Id id) {
    if (id.isEmpty) {
      return Future.value();
    }

    return database
        .onePathById(id.valueOrThrow())
        .map(FolderSqlMapper.folderPath)
        .getSingleOrNull();
  }
}
