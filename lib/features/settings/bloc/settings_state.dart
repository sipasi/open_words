part of 'settings_bloc.dart';

class SettingsState {
  final ColorSeed themeSeed;
  final ThemeMode themeMode;
  final TranslatorOption translatorOption;

  SettingsState({
    required this.themeSeed,
    required this.themeMode,
    required this.translatorOption,
  });

  SettingsState.initial()
    : themeSeed = ColorSeed.blue,
      themeMode = ThemeMode.dark,
      translatorOption = TranslatorOption.google;

  SettingsState copyWith({
    ColorSeed? themeSeed,
    ThemeMode? themeMode,
    TranslatorOption? translatorOption,
  }) {
    return SettingsState(
      themeSeed: themeSeed ?? this.themeSeed,
      themeMode: themeMode ?? this.themeMode,
      translatorOption: translatorOption ?? this.translatorOption,
    );
  }
}
