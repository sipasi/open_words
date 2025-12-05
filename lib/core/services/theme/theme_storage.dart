import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/app_theme.dart';
import 'package:open_words/shared/theme/color_seed.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeStorage {
  AppTheme get();

  void set(AppTheme theme);
}

final class PreferencesThemeStorage extends ThemeStorage {
  static const _keyMode = 'key_theme_storage_mode';
  static const _keySeed = 'key_theme_storage_seed';
  static const _keyOledBackground = 'key_theme_storage_oled_background';

  final SharedPreferences _preferences;

  PreferencesThemeStorage({required SharedPreferences preferences})
    : _preferences = preferences;

  @override
  AppTheme get() {
    if (_preferences.containsKey(_keyMode)) {
      ThemeMode theme = modeValue();
      ColorSeed seed = seedValue();
      bool oledBackground = oledBackgroundValue();

      return AppTheme(
        mode: theme,
        seed: seed,
        oledBackground: oledBackground,
      );
    }

    return AppTheme(
      mode: ThemeMode.dark,
      seed: ColorSeed.values[0],
      oledBackground: true,
    );
  }

  @override
  void set(AppTheme theme) {
    _preferences.setInt(_keyMode, theme.mode.index);
    _preferences.setInt(_keySeed, theme.seed.index);
    _preferences.setBool(_keyOledBackground, theme.oledBackground);
  }

  ThemeMode modeValue() {
    int? value = _preferences.getInt(_keyMode);

    if (value == null || value >= ThemeMode.values.length) {
      return ThemeMode.dark;
    }

    return ThemeMode.values[value];
  }

  ColorSeed seedValue() {
    const colors = ColorSeed.values;

    final index = _preferences.getInt(_keySeed);

    if (index == null) {
      return colors[0];
    }

    return colors[index % colors.length];
  }

  bool oledBackgroundValue() {
    bool? value = _preferences.getBool(_keyOledBackground);

    return value ?? false;
  }
}
