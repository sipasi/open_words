part of 'settings_bloc.dart';

sealed class SettingsEvent {}

final class SettingsInitRequested extends SettingsEvent {}

final class SettingsTranslatorChanged extends SettingsEvent {
  final TranslatorTemplate value;

  SettingsTranslatorChanged(this.value);
}

final class SettingsAiBridgeChanged extends SettingsEvent {
  final AiTemplate value;

  SettingsAiBridgeChanged(this.value);
}
