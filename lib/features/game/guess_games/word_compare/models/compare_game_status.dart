enum CompareGameStatus {
  notStarted,
  playing,
  finished;

  bool get isNotStarted => this == notStarted;
  bool get isPlaying => this == playing;
  bool get isFinished => this == finished;
}
