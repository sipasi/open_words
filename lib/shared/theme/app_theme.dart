import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/color_seed.dart';

class AppTheme {
  final ThemeMode mode;
  final ColorSeed seed;

  const AppTheme({required this.mode, required this.seed});

  ThemeData asDark() => _create(Brightness.dark);
  ThemeData asLight() => _create(Brightness.light);

  ThemeData _create(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorSchemeSeed: seed.color,
      pageTransitionsTheme: PageTransitionsTheme(
        builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
          TargetPlatform.values,
          value: (_) => const FadeForwardsPageTransitionsBuilder(),
        ),
      ),
    );
  }

  AppTheme copyWith({ThemeMode? mode, ColorSeed? seed}) {
    return AppTheme(mode: mode ?? this.mode, seed: seed ?? this.seed);
  }
}
