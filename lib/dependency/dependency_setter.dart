import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:open_words/service/clipboard_service.dart';
import 'package:open_words/service/language/language_info_service.dart';
import 'package:open_words/service/metadata/dev_dictionary_api.dart';
import 'package:open_words/service/metadata/metadata_service.dart';
import 'package:open_words/service/metadata/metadata_web_finder.dart';
import 'package:open_words/service/text_to_speech_service.dart';
import 'package:open_words/storage/metadata_storage.dart';
import 'package:open_words/storage/storage_factory.dart';
import 'package:open_words/storage/word_group_storage.dart';

abstract class AppDependencySetter {
  static Future set() async {
    final instance = GetIt.I;

    final storage = await StorageFactory.createDefault();

    instance.registerSingleton<WordGroupStorage>(storage.$1);
    instance.registerSingleton<MetadataStorage>(storage.$2);

    instance.registerSingleton<LanguageInfoService>(LanguageInfoService());
    instance.registerSingleton<TextToSpeechService>(TextToSpeechService());
    instance.registerSingleton<ClipboardService>(ClipboardService());

    instance.registerSingleton(Logger());

    registerMetadataServices(instance);
  }

  static void registerMetadataServices(GetIt instance) {
    final webApi = DevDictionaryApi();

    final webFinder = MetadataWebFinder(webApi);

    instance.registerSingleton(webFinder);

    instance.registerLazySingleton(() {
      final ser = MetadataService(
        storage: GetIt.I.get<MetadataStorage>(),
        webFinder: GetIt.I.get<MetadataWebFinder>(),
      );

      return ser;
    });
  }
}
