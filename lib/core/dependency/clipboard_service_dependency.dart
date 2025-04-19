import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/clipboard/clipboard.dart';

final class ClipboardServiceDependency extends AppDependency {
  @override
  Future inject(GetIt container) {
    container.registerSingleton<ClipboardService>(ClipboardServiceImpl());

    return Future.value();
  }
}
