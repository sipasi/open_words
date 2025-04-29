import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/dev_dictionary_api.dart';
import 'package:open_words/core/services/word_metadata/word_metadata_service.dart';
import 'package:open_words/core/services/word_metadata/word_metadata_web_api.dart';

final class WordMetadataServiceDependency extends AppDependency {
  @override
  Future inject(GetIt container) {
    container.registerSingleton<WordMetadataWebApi>(DevDictionaryApi());

    container.registerSingleton<WordMetadataService>(
      WordMetadataService(
        webLookup: container.get(),
        repository: container.get(),
        api: container.get(),
      ),
    );

    return Future.value();
  }
}
