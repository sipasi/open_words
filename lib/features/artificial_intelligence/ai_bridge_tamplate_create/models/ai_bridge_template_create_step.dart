enum AiBridgeTemplateCreateStep {
  connectionType("Connection"),
  url("Url"),
  model("Model");

  final String label;
  const AiBridgeTemplateCreateStep(this.label);

  bool get isConnectionType => this == connectionType;
  bool get isUrl => this == url;
  bool get isModel => this == model;
}
