import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/dev_dictionary_api.dart';
import 'package:open_words/core/services/word_metadata/word_metadata_service.dart';

final class WordMetadataServiceDependency extends AppDependency {
  @override
  Future inject(GetIt container) {
    container.registerSingleton<WordMetadataService>(
      WordMetadataService(repository: container.get(), api: DevDictionaryApi()),
    );

    return Future.value();
  }
}
