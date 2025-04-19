import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/logger/app_logger.dart';
import 'package:open_words/core/services/path/app_directory_provider.dart';

final class LoggerDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    final logger = await AppLoggerImpl.create(
      container.get<AppDirectoryProvider>(),
    );

    container.registerSingleton<AppLogger>(logger);
  }
}
