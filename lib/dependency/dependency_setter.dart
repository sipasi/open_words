import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:open_words/service/export/path_factory/system_path_factory.dart';
import 'package:open_words/service/export/path_factory/web_path_factory.dart';
import 'package:open_words/service/export/save_provider/local_saver.dart';
import 'package:open_words/service/export/save_provider/web_browser_saver.dart';
import 'package:open_words/service/export/word_group/word_group_export_service.dart';
import 'package:open_words/service/export/word_group/word_group_formatter_factory.dart';
import 'package:open_words/view/settings/export/export_page.dart';
import 'package:open_words/view/settings/export/export_view_model.dart';
import 'package:open_words/view/settings/export/import_page.dart';
import 'package:open_words/view/settings/export/import_view_model.dart';
import 'package:open_words/view/settings/settings_view_model.dart';
import 'package:open_words/view/word_group/list/word_group_list_view_model.dart';
import 'package:open_words/service/clipboard_service.dart';
import 'package:open_words/service/language/language_info_service.dart';
import 'package:open_words/service/metadata/dev_dictionary_api.dart';
import 'package:open_words/service/metadata/metadata_service.dart';
import 'package:open_words/service/metadata/metadata_web_finder.dart';
import 'package:open_words/service/text_to_speech_service.dart';
import 'package:open_words/storage/metadata_storage.dart';
import 'package:open_words/storage/storage_factory.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/view/settings/settings_page.dart';
import 'package:open_words/view/word_group/list/word_group_list_page.dart';

abstract class AppDependencySetter {
  static Future set() async {
    final instance = GetIt.I;

    await registerStorages(instance);

    instance.registerSingleton<LanguageInfoService>(LanguageInfoService());
    instance.registerSingleton<TextToSpeechService>(TextToSpeechService());
    instance.registerSingleton<ClipboardService>(ClipboardService());

    instance.registerSingleton(Logger());

    _registerExportService(instance);

    _registerViewModels(instance);
    _registerPages(instance);

    _registerMetadatas(instance);
  }

  static Future registerStorages(GetIt instance) async {
    final storage = await StorageFactory.createDefault();

    instance.registerSingleton<WordGroupStorage>(storage.$1);
    instance.registerSingleton<MetadataStorage>(storage.$2);
  }

  static void _registerExportService(GetIt instance) {
    final factory = WordGroupFormatterFactory();
    final path = _whenWeb(
      then: () => WebPathFactory(),
      other: () => SystemPathFactory(),
    );
    final saver = _whenWeb(
      then: () => WebBrowserSaver(),
      other: () => LocalSaver(),
    );

    final service = WordGroupExportService(factory, path, saver);

    instance.registerSingleton<WordGroupExportService>(service);
  }

  static void _registerViewModels(GetIt instance) {
    instance.registerFactory<WordGroupListViewModel>(() => WordGroupListViewModel(instance.get<WordGroupStorage>()));

    instance.registerFactory<SettingsViewModel>(() => SettingsViewModel());

    instance.registerFactory<ImportViewModel>(() => ImportViewModel(instance.get<WordGroupStorage>()));
    instance.registerFactory<ExportViewModel>(() => ExportViewModel(instance.get<WordGroupStorage>()));
  }

  static void _registerPages(GetIt instance) {
    instance.registerFactory<WordGroupListPage>(() => const WordGroupListPage());

    instance.registerFactory<SettingsPage>(() => const SettingsPage());

    instance.registerFactory<ExportPage>(() => const ExportPage());
    instance.registerFactory<ImportPage>(() => const ImportPage());
  }

  static void _registerMetadatas(GetIt instance) {
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

  static T _whenWeb<T>({required T Function() then, required T Function() other}) {
    return kIsWeb ? then() : other();
  }
}
