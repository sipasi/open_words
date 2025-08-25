part of 'ai_bridge_config_bloc.dart';

sealed class AiBridgeConfigEvent {}

final class AiBridgeConfigStarted extends AiBridgeConfigEvent {}

final class AiBridgeConfigClearAllRequested extends AiBridgeConfigEvent {
  AiBridgeConfigClearAllRequested();
}

final class AiBridgeConfigTemplateCreated extends AiBridgeConfigEvent {
  final AiTemplate value;

  AiBridgeConfigTemplateCreated(this.value);
}

final class AiBridgeConfigTemplateModified extends AiBridgeConfigEvent {
  final AiTemplate initial;
  final AiTemplate newValue;

  AiBridgeConfigTemplateModified({
    required this.initial,
    required this.newValue,
  });
}

final class AiBridgeConfigTemplateDeleted extends AiBridgeConfigEvent {
  final AiTemplate value;

  AiBridgeConfigTemplateDeleted(this.value);
}

final class AiBridgeConfigSelectedChanged extends AiBridgeConfigEvent {
  final AiTemplate value;

  AiBridgeConfigSelectedChanged(this.value);
}
