import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/secure_storage/secure_storage.dart';

final class SecuteStorageDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    container.registerSingleton<SecureStorage>(
      SecureStorageImpl(),
    );
  }
}
