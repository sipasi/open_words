import 'package:open_words/core/data/entities/entity_id.dart';
import 'package:open_words/core/data/entities/folder/folder.dart';
import 'package:open_words/core/data/entities/folder/folder_path.dart';
import 'package:open_words/core/data/repository/mappers/folder_sql_mapper.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';
import 'package:open_words/core/data/sources/drift/tables/folders_query.dart';

sealed class FolderRepository {
  Future<List<Folder>> all();
  Future<List<Folder>> allByParent(EntityId parent);

  Future<Folder?> oneById(EntityId id);
  Future<Folder?> oneByName(String name);

  Future delete(EntityId id);

  Future<Folder> create({required EntityId parentId, required String name});
  Future<Folder> update({required EntityId id, EntityId parentId, String name});

  Future<List<FolderPath>> allPath();
  Future<List<FolderPath>> allMovablePathBy(EntityId id);
  Future<FolderPath?> onePath(EntityId id);
}

class FolderRepositoryImpl extends FolderRepository {
  final AppDriftDatabase database;

  FolderRepositoryImpl(this.database);

  @override
  Future<List<Folder>> all() {
    return database.allFolders().map(FolderSqlMapper.from).get();
  }

  @override
  Future<List<Folder>> allByParent(EntityId parentId) {
    if (parentId.isEmpty) {
      return database.allFoldersByRoot().map(FolderSqlMapper.from).get();
    }

    return database
        .allFoldersByParent(parentId.valueOrThrow())
        .map(FolderSqlMapper.from)
        .get();
  }

  @override
  Future<Folder?> oneById(EntityId id) {
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
  Future<Folder> create({EntityId? parentId, required String name}) async {
    final id = await database
        .into(database.folders)
        .insert(FolderSqlMapper.toCreate(parentId: parentId, name: name));

    final entity = await oneById(EntityId.exist(id));

    return entity!;
  }

  @override
  Future<Folder> update({required EntityId id, EntityId? parentId, String? name}) async {
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
  Future delete(EntityId id) {
    return database.managers.folders
        .filter((f) => f.id.equals(id.valueOrNull()))
        .delete();
  }

  @override
  Future<List<FolderPath>> allPath() async {
    final result =
        await database.allPath().map(FolderSqlMapper.folderPath).get();

    return [const FolderPath.root(), ...result];
  }

  @override
  Future<List<FolderPath>> allMovablePathBy(EntityId id) async {
    if (id.isEmpty) {
      return Future.value([]);
    }

    final result =
        await database
            .allMovablePath(id.valueOrThrow())
            .map(FolderSqlMapper.folderPath)
            .get();

    return [const FolderPath.root(), ...result];
  }

  @override
  Future<FolderPath?> onePath(EntityId id) {
    if (id.isEmpty) {
      return Future.value();
    }

    return database
        .onePathById(id.valueOrThrow())
        .map(FolderSqlMapper.folderPath)
        .getSingleOrNull();
  }
}
