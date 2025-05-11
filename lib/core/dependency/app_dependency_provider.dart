import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/dependency/clipboard_service_dependency.dart';
import 'package:open_words/core/dependency/directories_dependency.dart';
import 'package:open_words/core/dependency/file_local_save_service_dependency.dart';
import 'package:open_words/core/dependency/file_picker_service_dependency.dart';
import 'package:open_words/core/dependency/file_share_service_dependency.dart';
import 'package:open_words/core/dependency/file_temporary_service_dependency.dart';
import 'package:open_words/core/dependency/language_info_service_dependency.dart';
import 'package:open_words/core/dependency/logger_dependency.dart';
import 'package:open_words/core/dependency/repository_dependency.dart';
import 'package:open_words/core/dependency/theme_storage_dependency.dart';
import 'package:open_words/core/dependency/translator_services_dependency.dart';
import 'package:open_words/core/dependency/vibration_service_dependency.dart';
import 'package:open_words/core/dependency/word_metadata_service_dependency.dart';

abstract class AppDependencyProvider {
  static Future init() async {
    final instance = GetIt.I;

    final dependencies = _getDependencies();

    for (var dependency in dependencies) {
      await dependency.inject(instance);
    }
  }

  static List<AppDependency> _getDependencies() {
    return [
      DirectoriesDependency(),
      FileLocalSaveServiceDependency(),
      FileTemporaryServiceDependency(),
      FileShareServiceDependency(),
      FilePickerServiceDependency(),
      LoggerDependency(),
      ThemeStorageDependency(),
      RepositoryDependency(),
      VibrationServiceDependency(),
      LanguageInfoServiceDependency(),
      TranslatorServicesDependency(),
      ClipboardServiceDependency(),
      WordMetadataServiceDependency(),
    ];
  }
}
