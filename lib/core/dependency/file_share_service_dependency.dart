import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/file/share/file_share_service.dart';
import 'package:share_plus/share_plus.dart';

final class FileShareServiceDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    container.registerSingleton<FileShareService>(
      FileShareServiceImpl(
        share: SharePlus.instance,
        fileService: container.get(),
        webService: container.get(),
      ),
    );
  }
}
