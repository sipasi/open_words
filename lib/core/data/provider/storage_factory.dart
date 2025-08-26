import 'package:open_words/core/data/repository/explorer_repository.dart';
import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/data/repository/word_metadata_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/core/data/repository/word_statistic_repository.dart';
import 'package:open_words/core/data/repository/word_web_lookup_repository.dart';
import 'package:open_words/core/data/sources/app_database.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';
import 'package:open_words/core/services/language/language_info_service.dart';
import 'package:open_words/core/services/logger/app_logger.dart';

class StorageSet {
  final AppDatabase database;
  final FolderRepository folderRepository;
  final WordGroupRepository groupRepository;
  final WordRepository wordRepository;
  final WordStatisticRepository wordStatisticRepository;
  final WordMetadataRepository wordMetadataRepository;
  final WordWebLookupRepository webLookupRepository;
  final ExplorerRepository explorerRepository;

  StorageSet({
    required this.database,
    required this.folderRepository,
    required this.groupRepository,
    required this.wordRepository,
    required this.wordStatisticRepository,
    required this.wordMetadataRepository,
    required this.webLookupRepository,
    required this.explorerRepository,
  });
}

class StorageFactory {
  static Future<StorageSet> _drift({
    required AppLogger logger,
    required LanguageInfoService languages,
  }) async {
    final database = AppDriftDatabase();

    final groups = WordGroupRepositoryImpl(
      database,
      languages: languages,
      logger: logger,
    );
    final folders = FolderRepositoryImpl(database);

    return StorageSet(
      database: AppDatabaseImpl(database),
      folderRepository: folders,
      groupRepository: groups,
      wordRepository: WordRepositoryImpl(database),
      wordStatisticRepository: WordStatisticRepositoryImpl(database),
      wordMetadataRepository: WordMetadataRepositoryImpl(database),
      webLookupRepository: WordWebLookupRepositoryImpl(database),
      explorerRepository: ExplorerRepositoryImpl(database, groups, folders),
    );
  }

  static Future<StorageSet> createDefault({
    required AppLogger logger,
    required LanguageInfoService languages,
  }) => _drift(logger: logger, languages: languages);
}
