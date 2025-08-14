part of 'ai_bridge_template_create_cubit.dart';

class AiBridgeTemplateCreateState {
  final AiBridgeTemplateCreateStep step;

  final LocalIpAddresses localIp;

  final AiBridgeType bridgeType;
  final String url;
  final String model;
  final String api;

  final AiBridgeTemplateModelLoading modelLoading;

  final List<AiBridgeTemplateModelOption> models;

  bool get isLastStep => AiBridgeTemplateCreateStep.values.last == step;

  bool get isValidStep => switch (step) {
    AiBridgeTemplateCreateStep.url => url.isNotEmpty,
    AiBridgeTemplateCreateStep.connectionType =>
      bridgeType.isNotConfigured == false,
    AiBridgeTemplateCreateStep.model => model.isNotEmpty,
  };

  const AiBridgeTemplateCreateState({
    required this.step,
    required this.localIp,
    required this.bridgeType,
    required this.url,
    required this.model,
    required this.api,
    required this.modelLoading,
    required this.models,
  });
  const AiBridgeTemplateCreateState.initial()
    : step = AiBridgeTemplateCreateStep.connectionType,
      localIp = const LocalIpAddresses.empty(),
      bridgeType = AiBridgeType.notConfigured,
      url = '',
      model = '',
      modelLoading = AiBridgeTemplateModelLoading.none,
      models = const [],
      api = '';

  AiBridgeTemplateCreateState copyWith({
    AiBridgeTemplateCreateStep? step,
    LocalIpAddresses? localIp,
    AiBridgeType? bridgeType,
    String? url,
    String? port,
    String? model,
    String? api,
    AiBridgeTemplateModelLoading? modelLoading,
    List<AiBridgeTemplateModelOption>? models,
  }) {
    return AiBridgeTemplateCreateState(
      step: step ?? this.step,
      localIp: localIp ?? this.localIp,
      bridgeType: bridgeType ?? this.bridgeType,
      model: model ?? this.model,
      url: url ?? this.url,
      api: api ?? this.api,
      modelLoading: modelLoading ?? this.modelLoading,
      models: models ?? this.models,
    );
  }
}
