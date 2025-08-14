enum AiBridgeType {
  notConfigured,
  local,
  lan,
  remote;

  bool get isNotConfigured => this == notConfigured;
  bool get isLocal => this == local;
  bool get isLan => this == lan;
  bool get isRemote => this == remote;

  bool get isLanOrLocal => this == lan || this == local;
}
