import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/color_seed.dart';

class AppTheme {
  final ThemeMode mode;
  final ColorSeed seed;
  final bool oledBackground;

  const AppTheme({
    required this.mode,
    required this.seed,
    required this.oledBackground,
  });

  ThemeData asDark() => _create(Brightness.dark);
  ThemeData asLight() => _create(Brightness.light);

  ThemeData _create(Brightness brightness) {
    final oled = oledBackground && brightness == .dark ? Colors.black : null;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: .fromSeed(
        seedColor: seed.color,
        brightness: brightness,
        surface: oled,
        surfaceContainer: oled,
      ),
      scaffoldBackgroundColor: oled,
      pageTransitionsTheme: PageTransitionsTheme(
        builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
          TargetPlatform.values,
          value: (_) => const FadeForwardsPageTransitionsBuilder(),
        ),
      ),
    );
  }

  AppTheme copyWith({
    ThemeMode? mode,
    ColorSeed? seed,
    bool? oledBackground,
  }) {
    return AppTheme(
      mode: mode ?? this.mode,
      seed: seed ?? this.seed,
      oledBackground: oledBackground ?? this.oledBackground,
    );
  }
}
