import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/core/data/sources/app_database.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

class StorageSet {
  final AppDatabase database;
  final FolderRepository folderRepository;
  final WordGroupRepository groupRepository;
  final WordRepository wordRepository;

  StorageSet({
    required this.database,
    required this.folderRepository,
    required this.groupRepository,
    required this.wordRepository,
  });
}

class StorageFactory {
  static Future<StorageSet> _drift() async {
    final database = AppDriftDatabase();

    return StorageSet(
      database: AppDatabaseImpl(database),
      folderRepository: FolderRepositoryImpl(database),
      groupRepository: WordGroupRepositoryImpl(database),
      wordRepository: WordRepositoryImpl(database),
    );
  }

  static Future<StorageSet> createDefault() => _drift();
}
