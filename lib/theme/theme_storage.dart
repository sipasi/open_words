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

  static ThemeMode modeValue() => _toEnum(_preferences.getInt(_keyTheme));
  static int colorValue() => _preferences.getInt(_keyColor) ?? 0;

  static AppTheme get() {
    if (_preferences.containsKey(_keyTheme)) {
      ThemeMode theme = modeValue();
      int color = colorValue();

      return AppTheme(
        mode: theme,
        seed: ColorSeed.values[color],
      );
    }

    return AppTheme(
      mode: ThemeMode.dark,
      seed: ColorSeed.values[0],
    );
  }

  static void set(AppTheme theme) {
    _preferences.setInt(_keyTheme, theme.mode.index);
    _preferences.setInt(_keyColor, theme.seed.index);
  }

  static ThemeMode _toEnum(int? value) {
    if (value == null || value >= ThemeMode.values.length) {
      return ThemeMode.dark;
    }

    return ThemeMode.values[value];
  }
}
