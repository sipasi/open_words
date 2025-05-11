import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/file/picker/file_picker_service.dart';

final class FilePickerServiceDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    container.registerSingleton<FilePickerService>(FilePickerServiceImpl());
  }
}
