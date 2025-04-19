import 'package:vibration/vibration.dart';

sealed class VibrationService {
  Future tap();
}

final class VibrationServiceImpl extends VibrationService {
  @override
  Future tap() async {
    if (await Vibration.hasVibrator()) {
      return Vibration.vibrate(duration: 100, amplitude: 25);
    }
  }
}
