part of 'settings_bloc.dart';

sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoadSuccess extends SettingsState {
  final ColorSeed themeSeed;
  final ThemeMode themeMode;
  final TranslatorOption translatorOption;

  SettingsLoadSuccess({
    required this.themeSeed,
    required this.themeMode,
    required this.translatorOption,
  });

  SettingsLoadSuccess copyWith({
    ColorSeed? themeSeed,
    ThemeMode? themeMode,
    TranslatorOption? translatorOption,
  }) {
    return SettingsLoadSuccess(
      themeSeed: themeSeed ?? this.themeSeed,
      themeMode: themeMode ?? this.themeMode,
      translatorOption: translatorOption ?? this.translatorOption,
    );
  }
}
