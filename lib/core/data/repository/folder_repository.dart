import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/folder/folder.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class FolderRepository {
  Future<List<Folder>> all();
  Future<List<Folder>> allByParent(Id parent);
  Future<Folder?> byId(Id id);

  Future<Folder> create({required Id parentFolder, required String name});
  Future<Folder> update({
    required Id id,
    required Id parentFolder,
    required String name,
  });
}

class FolderRepositoryImpl extends FolderRepository {
  final AppDriftDatabase database;

  FolderRepositoryImpl(this.database);

  @override
  Future<List<Folder>> all() {
    return database.managers.folders.map(_mapFolder).get();
  }

  @override
  Future<List<Folder>> allByParent(Id parent) {
    return database.managers.folders
        .filter((f) => f.parentId.id.equals(parent.valueOrNull()))
        .map(_mapFolder)
        .get();
  }

  @override
  Future<Folder?> byId(Id id) {
    return database.managers.folders
        .filter((f) => f.id.equals(id.valueOrNull()))
        .map(_mapFolder)
        .getSingleOrNull();
  }

  @override
  Future<Folder> create({
    required Id parentFolder,
    required String name,
  }) async {
    final now = DateTime.now();

    final id = await database.managers.folders.create(
      (o) => o(
        parentId: Value.absentIfNull(parentFolder.valueOrNull()),
        created: now,
        name: name,
      ),
    );

    final entity = await byId(Id.exist(id));

    return entity!;
  }

  @override
  Future<Folder> update({
    required Id id,
    required Id parentFolder,
    required String name,
  }) async {
    await database.managers.folders
        .filter((f) => f.id.equals(id.valueOrNull()))
        .update(
          (o) => o(
            parentId: Value.absentIfNull(parentFolder.valueOrNull()),

            name: Value(name),
          ),
        );

    final entity = await byId(id);

    return entity!;
  }

  Folder _mapFolder(DriftFolder element) {
    return Folder(
      id: Id.exist(element.id),
      parentId: Id.emptyIfNull(element.parentId),
      name: element.name,
      created: element.created,
    );
  }
}
