import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/language/language_info_service.dart';

final class LanguageInfoServiceDependency extends AppDependency {
  @override
  Future inject(GetIt container) {
    container.registerSingleton<LanguageInfoService>(LanguageInfoServiceImpl());

    return Future.value();
  }
}
