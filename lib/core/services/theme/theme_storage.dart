import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/app_theme.dart';
import 'package:open_words/shared/theme/color_seed.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeStorage {
  AppTheme get();

  void set(AppTheme theme);
}

final class PreferencesThemeStorage extends ThemeStorage {
  static const _keyMode = 'key_mode';
  static const _keySeed = 'key_seed';

  final SharedPreferences _preferences;

  PreferencesThemeStorage({required SharedPreferences preferences})
    : _preferences = preferences;

  @override
  AppTheme get() {
    if (_preferences.containsKey(_keyMode)) {
      ThemeMode theme = modeValue();
      ColorSeed seed = seedValue();

      return AppTheme(mode: theme, seed: seed);
    }

    return AppTheme(mode: ThemeMode.dark, seed: ColorSeed.values[0]);
  }

  @override
  void set(AppTheme theme) {
    _preferences.setInt(_keyMode, theme.mode.index);
    _preferences.setInt(_keySeed, theme.seed.index);
  }

  ThemeMode modeValue() => _toEnum(_preferences.getInt(_keyMode));
  ColorSeed seedValue() {
    const colors = ColorSeed.values;

    final index = _preferences.getInt(_keySeed);

    if (index == null) {
      return colors[0];
    }

    return colors[index % colors.length];
  }

  ThemeMode _toEnum(int? value) {
    if (value == null || value >= ThemeMode.values.length) {
      return ThemeMode.dark;
    }

    return ThemeMode.values[value];
  }
}
