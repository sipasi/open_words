// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ai_bridge_config_bloc.dart';

class AiBridgeConfigState {
  final AiTemplate selected;
  final List<AiTemplate> templates;

  final AiTemplateLoadStatus loadStatus;

  AiBridgeConfigState({
    required this.selected,
    required this.templates,
    required this.loadStatus,
  });

  const AiBridgeConfigState.initial()
    : selected = const AiTemplate.empty(),
      templates = const [],
      loadStatus = AiTemplateLoadStatus.loading;

  AiBridgeConfigState copyWith({
    AiTemplate? selected,
    List<AiTemplate>? templates,
    AiTemplateLoadStatus? loadStatus,
  }) {
    return AiBridgeConfigState(
      selected: selected ?? this.selected,
      templates: templates ?? this.templates,
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }
}

enum AiTemplateLoadStatus { loading, finished }
