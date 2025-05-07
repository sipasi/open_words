/// Defines the type of quiz size to be used.
///
/// - [min]: Use the minimum allowed number of questions.
/// - [max]: Use the maximum allowed number of questions.
/// - [custom]: Use a custom-defined number of questions.
enum QuizSizeType { min, max, custom }

/// Represents the size configuration for a quiz, including min, max, and preferred values.
///
/// This class provides constructors to define whether the quiz size should be
/// the minimum, maximum, or a custom value, and calculates the effective size accordingly.
final class QuizSize {
  /// The strategy to determine the preferred quiz size (min, max, or custom).
  final QuizSizeType type;

  /// The maximum number of questions allowed in the quiz.
  final int allowedMax;

  /// The minimum number of questions allowed in the quiz.
  final int allowedMin;

  /// The custom preferred number of questions to be used if [type] is [QuizSizeType.custom].
  final int preferred;

  /// Returns the number of questions to use based on [type].
  ///
  /// - If [type] is [QuizSizeType.min], returns [allowedMin].
  /// - If [type] is [QuizSizeType.max], returns [allowedMax].
  /// - If [type] is [QuizSizeType.custom], returns [preferred].
  int get preferredSize => switch (type) {
    QuizSizeType.min => allowedMin,
    QuizSizeType.max => allowedMax,
    QuizSizeType.custom => preferred,
  };

  QuizSize({
    required this.type,
    required this.allowedMax,
    required this.allowedMin,
    required this.preferred,
  });

  /// Creates a [QuizSize] that uses the minimum allowed size.
  QuizSize.min({required this.allowedMax, required this.allowedMin})
    : type = QuizSizeType.min,
      preferred = allowedMin;

  /// Creates a [QuizSize] that uses the maximum allowed size.
  QuizSize.max({required this.allowedMax, required this.allowedMin})
    : type = QuizSizeType.max,
      preferred = allowedMax;

  /// Creates a [QuizSize] that uses a custom preferred size.
  QuizSize.custom({
    required this.allowedMax,
    required this.allowedMin,
    required this.preferred,
  }) : type = QuizSizeType.custom;
}
