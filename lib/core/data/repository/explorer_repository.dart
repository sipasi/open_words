import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/explorer/explorer_data.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/core/data/repository/mappers/explorer_sql_mapper.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class ExplorerRepository {
  Future<ExplorerData> allByFolder(Id folderId);
  Future<ExplorerData> allByFolderViaRepo(Id folderId);
}

class ExplorerRepositoryImpl extends ExplorerRepository {
  final WordGroupRepository groupRepository;
  final FolderRepository folderRepository;

  final AppDriftDatabase database;

  ExplorerRepositoryImpl(
    this.database,
    this.groupRepository,
    this.folderRepository,
  );

  @override
  Future<ExplorerData> allByFolder(Id folderId) async {
    final rows = await database.allByFolderQuery(folderId).get();

    return ExplorerSqlMapper.fromList(rows);
  }

  @override
  Future<ExplorerData> allByFolderViaRepo(Id folderId) async {
    return ExplorerData(
      folders: await folderRepository.allByParent(folderId),
      groups: await groupRepository.allByFolder(folderId),
    );
  }
}

extension _Queries on AppDriftDatabase {
  Selectable<QueryRow> allByFolderQuery(Id folderId) {
    return customSelect(_query(folderId));
  }

  static String _query(Id parentFolder) {
    final predicate =
        parentFolder.isEmpty ? 'IS NULL' : '= ${parentFolder.valueOrNull()}';

    final template =
        'SELECT id, parent_id AS parent_id, name, created, NULL AS modified, '
        'NULL AS language_origin_code, NULL AS language_origin_name, NULL AS language_origin_native, '
        'NULL AS language_translation_code, NULL AS language_translation_name, NULL AS language_translation_native, '
        '\'Folder\' AS entity_type '
        'FROM folders '
        'WHERE parent_id $predicate '
        ''
        'UNION ALL '
        ''
        'SELECT id, folder_id, name, created, modified, '
        'language_origin_code, language_origin_name, language_origin_native, '
        'language_translation_code, language_translation_name, language_translation_native, '
        '\'WordGroup\' AS entity_type '
        'FROM word_groups '
        'WHERE folder_id $predicate;';

    return template;
  }
}
