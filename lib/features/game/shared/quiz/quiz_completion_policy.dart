/// Defines the policy for determining when a quiz question is considered "completed".
///
/// This enum helps control the conditions under which a question is counted as
/// answered in the quiz, affecting how progress is tracked and how scores are calculated.
///
/// There are two completion policies:
///
/// - [anyAttempt]: A question is considered complete as soon as the user provides any answer,
///   whether correct or incorrect. This allows for quicker progress tracking, even if mistakes are made.
///
/// - [correctOnly]: A question is considered complete only when the user answers it correctly.
///   The user must provide the correct answer to move forward, making this more restrictive for tracking progress.
enum QuizCompletionPolicy {
  /// Any attempt (correct or incorrect) marks a question as completed
  anyAttempt,

  /// Only a correct attempt marks a question as completed
  correctOnly;

  bool get isAnyAttempt => this == anyAttempt;
  bool get isCorrectOnly => this == correctOnly;

  bool allowsIncorrectCompletion() => isAnyAttempt;
}
