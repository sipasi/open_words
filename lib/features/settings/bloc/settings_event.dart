part of 'settings_bloc.dart';

sealed class SettingsEvent {}

final class SettingsInitRequested extends SettingsEvent {}

final class SettingsTranslatorChanged extends SettingsEvent {
  final TranslatorOption value;

  SettingsTranslatorChanged(this.value);
}
