import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/entity_id.dart';
import 'package:open_words/core/data/entities/folder/folder.dart';
import 'package:open_words/core/data/entities/folder/folder_path.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class FolderSqlMapper {
  static Folder from(QueryRow row) {
    // print('from ${row.readNullable('id') ?? 'null'}');

    return Folder(
      id: EntityId.exist(row.read('id')),
      parentId: EntityId.emptyIfNull(row.readNullable('parent_id')),
      created: row.read('created'),
      name: row.read('name'),
    );
  }

  static Insertable<DriftFolder> toCreate({
    required String name,
    EntityId? parentId,
  }) {
    final now = DateTime.now();

    return FoldersCompanion.insert(
      parentId: Value.absentIfNull(parentId?.valueOrNull()),
      created: now,
      name: name,
    );
  }

  static Insertable<DriftFolder> toUpdate({EntityId? parentId, String? name}) {
    return FoldersCompanion(
      parentId: Value.absentIfNull(parentId?.valueOrNull()),
      name: Value.absentIfNull(name),
    );
  }

  static FolderPath folderPath(QueryRow row) {
    return FolderPath(
      folderId: EntityId.exist(row.read<int>('id')),
      parentId: EntityId.emptyIfNull(row.readNullable<int>('parent_id')),
      name: row.read<String>('name'),
      path: row.read<String>('full_path'),
    );
  }
}
