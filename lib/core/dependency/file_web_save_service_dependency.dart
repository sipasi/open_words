import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/file/web_file/web_file_service.dart';
import 'package:share_plus/share_plus.dart';

final class FileWebSaveServiceDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    container.registerSingleton<WebFileService>(
      WebFileServiceImpl(share: SharePlus.instance),
    );
  }
}
