import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/theme/theme_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class ThemeStorageDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    container.registerSingleton<ThemeStorage>(
      PreferencesThemeStorage(
        preferences: await SharedPreferences.getInstance(),
      ),
    );
  }
}
