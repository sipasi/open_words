import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/ai_bridge/ai_bridge_provider.dart';
import 'package:open_words/core/services/ai_bridge/ai_bridge_tamplate_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class ArtificialIntelligenceDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    final preferences = await SharedPreferences.getInstance();

    container.registerSingleton<AiBridgeProvider>(
      AiBridgeProviderImpl(preferences: preferences),
    );
    container.registerSingleton<AiBridgeTamplateStorage>(
      AiBridgeTamplateStorageImpl(preferences: preferences),
    );
  }
}
