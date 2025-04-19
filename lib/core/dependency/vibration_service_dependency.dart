import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';

final class VibrationServiceDependency extends AppDependency {
  @override
  Future inject(GetIt container) {
    container.registerSingleton<VibrationService>(VibrationServiceImpl());

    return Future.value();
  }
}
