part of 'settings_bloc.dart';

class SettingsState {
  final ColorSeed themeSeed;
  final ThemeMode themeMode;
  final TranslatorTemplate translatorTemplate;
  final AiBridgeTemplate aiBridgeTemplate;

  SettingsState({
    required this.themeSeed,
    required this.themeMode,
    required this.translatorTemplate,
    required this.aiBridgeTemplate,
  });

  SettingsState.initial()
    : themeSeed = ColorSeed.blue,
      themeMode = ThemeMode.dark,
      translatorTemplate = const TranslatorTemplate.google(),
      aiBridgeTemplate = const AiBridgeTemplate.empty();

  SettingsState copyWith({
    ColorSeed? themeSeed,
    ThemeMode? themeMode,
    TranslatorTemplate? translatorTemplate,
    AiBridgeTemplate? aiBridgeTemplate,
  }) {
    return SettingsState(
      themeSeed: themeSeed ?? this.themeSeed,
      themeMode: themeMode ?? this.themeMode,
      translatorTemplate: translatorTemplate ?? this.translatorTemplate,
      aiBridgeTemplate: aiBridgeTemplate ?? this.aiBridgeTemplate,
    );
  }
}
