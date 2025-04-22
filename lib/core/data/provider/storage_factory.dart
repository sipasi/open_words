import 'package:open_words/core/data/repository/explorer_repository.dart';
import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/data/repository/word_metadata_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/core/data/sources/app_database.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

class StorageSet {
  final AppDatabase database;
  final FolderRepository folderRepository;
  final WordGroupRepository groupRepository;
  final WordRepository wordRepository;
  final WordMetadataRepository wordMetadataRepository;
  final ExplorerRepository explorerRepository;

  StorageSet({
    required this.database,
    required this.folderRepository,
    required this.groupRepository,
    required this.wordRepository,
    required this.wordMetadataRepository,
    required this.explorerRepository,
  });
}

class StorageFactory {
  static Future<StorageSet> _drift() async {
    final database = AppDriftDatabase();

    final groups = WordGroupRepositoryImpl(database);
    final folders = FolderRepositoryImpl(database);

    return StorageSet(
      database: AppDatabaseImpl(database),
      folderRepository: folders,
      groupRepository: groups,
      wordRepository: WordRepositoryImpl(database),
      wordMetadataRepository: WordMetadataRepositoryImpl(database),
      explorerRepository: ExplorerRepositoryImpl(database, groups, folders),
    );
  }

  static Future<StorageSet> createDefault() => _drift();
}
