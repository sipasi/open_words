import 'package:flutter/material.dart';
import 'package:open_words/theme/app_theme.dart';
import 'package:open_words/theme/color/color_seed.dart';
import 'package:open_words/theme/theme_storage.dart';
import 'package:open_words/theme/theme_switcher.dart';

abstract class ThemeTileHelper {
  static void setTheme({
    required BuildContext context,
    int? color,
    int? mode,
  }) {
    mode = mode ?? ThemeStorage.modeValue();
    color = color ?? ThemeStorage.colorValue();

    AppTheme theme = AppTheme(
      mode: mode == 0 ? ThemeMode.dark : ThemeMode.light,
      seed: ColorSeed.values[color],
    );

    ThemeSwitcher.of(context).switchTheme(theme);

    ThemeStorage.set(theme);
  }
}
