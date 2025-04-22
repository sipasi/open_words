import 'package:open_words/core/data/entities/explorer/explorer_data.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class ExplorerRepository {
  Future<ExplorerData> allByFolder(Id folderId);
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
    return ExplorerData(
      folders: await folderRepository.allByParent(folderId),
      groups: await groupRepository.allByFolder(folderId),
    );
  }
}
