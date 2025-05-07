enum WordCompareAnswerEvent {
  correct,
  wrong;

  static WordCompareAnswerEvent from(bool result) {
    return result ? correct : wrong;
  }
}
