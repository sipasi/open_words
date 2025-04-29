import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/provider/storage_factory.dart';
import 'package:open_words/core/dependency/app_dependency.dart';

class RepositoryDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    final storage = await StorageFactory.createDefault();

    container.registerSingleton(storage.database);
    container.registerSingleton(storage.folderRepository);
    container.registerSingleton(storage.groupRepository);
    container.registerSingleton(storage.wordRepository);
    container.registerSingleton(storage.wordMetadataRepository);
    container.registerSingleton(storage.webLookupRepository);
    container.registerSingleton(storage.explorerRepository);
  }
}
