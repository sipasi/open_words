import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/language/translation/translator_option_storage.dart';
import 'package:open_words/core/services/language/translation/translator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class TranslatorServicesDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    final optionStorage = TranslatorOptionStorageImpl(
      await SharedPreferences.getInstance(),
    );
    final translatorUrl = TranslatorServiceImpl(optionStorage);

    container.registerSingleton<TranslatorOptionStorage>(optionStorage);
    container.registerSingleton<TranslatorService>(translatorUrl);
  }
}
