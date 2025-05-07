enum GuessGameStatus {
  notStarted,
  playing,
  gameEnd;

  bool get isNotStarted => this == notStarted;
  bool get isPlaying => this == playing;
  bool get isGameEnd => this == gameEnd;
}
