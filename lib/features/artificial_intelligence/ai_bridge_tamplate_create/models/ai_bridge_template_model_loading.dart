enum AiBridgeTemplateModelLoading {
  none,
  loading,
  loaded;

  bool get isNone => this == none;
  bool get isLoading => this == loading;
  bool get isLoaded => this == loaded;
}
