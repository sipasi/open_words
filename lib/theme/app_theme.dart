import 'package:flutter/material.dart';
import 'package:open_words/theme/color/color_seed.dart';

class AppTheme {
  final ThemeMode mode;
  final ColorSeed seed;

  const AppTheme({
    required this.mode,
    required this.seed,
  });

  ThemeData asDark() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: seed.color,
      );
  ThemeData asLight() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: seed.color,
      );

  AppTheme copyWith({
    ThemeMode? mode,
    ColorSeed? seed,
  }) =>
      AppTheme(mode: mode ?? this.mode, seed: seed ?? this.seed);
}
