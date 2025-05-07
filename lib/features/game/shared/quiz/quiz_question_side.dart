import 'package:open_words/core/data/entities/word/word.dart';

/// Represents a strategy for choosing which side of a [Word] to use in a quiz.
///
/// This sealed class allows for selecting either the original language (origin)
/// or the translated version of a word as the question, while the opposite side
/// becomes the answer variant.
sealed class QuizQuestionSide {
  /// Use the original word (e.g. in native language) as the question.
  static const QuizQuestionSide origin = _OriginSide();

  /// Use the translated word as the question.
  static const QuizQuestionSide translation = _TranslationSide();

  const QuizQuestionSide._();

  /// Returns the value to be used as the question.
  String question(Word word);

  /// Returns the value to be used as an answer option (variant).
  String variant(Word word);
}

final class _OriginSide extends QuizQuestionSide {
  const _OriginSide() : super._();

  @override
  String question(Word word) => word.origin;
  @override
  String variant(Word word) => word.translation;
}

final class _TranslationSide extends QuizQuestionSide {
  const _TranslationSide() : super._();

  @override
  String question(Word word) => word.translation;
  @override
  String variant(Word word) => word.origin;
}
