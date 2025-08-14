import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/ai_bridge/ai_bridge_provider.dart';
import 'package:open_words/core/services/ai_bridge/ai_bridge_tamplate_storage.dart';
import 'package:open_words/core/services/secure_storage/secure_storage.dart';

final class ArtificialIntelligenceDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    final secure = GetIt.I.get<SecureStorage>();

    container.registerSingleton<AiBridgeProvider>(
      AiBridgeProviderImpl(secure: secure),
    );
    container.registerSingleton<AiBridgeTamplateStorage>(
      AiBridgeTamplateStorageImpl(secure: secure),
    );
  }
}
