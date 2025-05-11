import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/file/local_save/local_file_service.dart';

final class FileLocalSaveServiceDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    container.registerSingleton<LocalFileService>(
      LocalFileServiceImpl(directoryProvider: container.get()),
    );
  }
}
