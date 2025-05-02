import 'package:vibration/vibration.dart';

enum VibrationDuration {
  short(30),
  medium(100),
  long(300);

  final int milliseconds;
  const VibrationDuration(this.milliseconds);
}

sealed class VibrationService {
  Future tap();
  Future lightImpact(VibrationDuration duration);
  Future mediumImpact(VibrationDuration duration);
  Future hardImpact(VibrationDuration duration);
}

final class VibrationServiceImpl extends VibrationService {
  Future<bool> canVibrate() async =>
      await Vibration.hasVibrator() && await Vibration.hasAmplitudeControl();

  @override
  Future tap() async {
    if (await canVibrate()) {
      await lightImpact(VibrationDuration.short);
    }
  }

  @override
  Future lightImpact(VibrationDuration duration) async {
    if (await canVibrate()) {
      await Vibration.vibrate(
        duration: duration.milliseconds,
        amplitude: 10,
        intensities: [],
      );
    }
  }

  @override
  Future mediumImpact(VibrationDuration duration) async {
    if (await canVibrate()) {
      await Vibration.vibrate(duration: duration.milliseconds, amplitude: 20);
    }
  }

  @override
  Future hardImpact(VibrationDuration duration) async {
    if (await canVibrate()) {
      await Vibration.vibrate(duration: duration.milliseconds, amplitude: 80);
    }
  }
}
