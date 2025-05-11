import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/file/temporary/temporary_file_service.dart';

final class FileTemporaryServiceDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    container.registerSingleton<TemporaryFileService>(
      TemporaryFileServiceImpl(localFileService: container.get()),
    );
  }
}
