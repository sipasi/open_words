import 'package:flutter/material.dart';
import 'package:open_words/theme/app_theme.dart';
import 'package:open_words/theme/color/color_seed.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeStorage {
  static const _keyTheme = 'key_theme';
  static const _keyColor = 'key_color';

  static late final SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static int modeValue() => _preferences.getInt(_keyTheme) ?? 0;
  static int colorValue() => _preferences.getInt(_keyColor) ?? 0;

  static AppTheme get() {
    if (_preferences.containsKey(_keyTheme)) {
      int theme = modeValue();
      int color = colorValue();

      return AppTheme(
        mode: theme == 0 ? ThemeMode.dark : ThemeMode.light,
        seed: ColorSeed.values[color],
      );
    }

    return AppTheme(
      mode: ThemeMode.dark,
      seed: ColorSeed.values[0],
    );
  }

  static void set(AppTheme theme) {
    _preferences.setInt(_keyTheme, theme.mode == ThemeMode.dark ? 0 : 1);
    _preferences.setInt(_keyColor, theme.seed.index);
  }
}
