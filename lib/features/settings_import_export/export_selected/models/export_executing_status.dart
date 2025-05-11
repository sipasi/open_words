enum ExportExecutingStatus {
  notStarted,
  executing,
  finished;

  bool get isNotStarted => this == notStarted;
  bool get isExecuting => this == executing;
  bool get isFinished => this == finished;
}
