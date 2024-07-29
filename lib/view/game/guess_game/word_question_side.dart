import 'package:open_words/data/word/word.dart';

abstract class WordQuestionSide {
  static const WordQuestionSide origin = _OriginSide();
  static const WordQuestionSide translation = _TranslationSide();

  const WordQuestionSide._();

  String question(Word word);
  String variant(Word word);
}

class _OriginSide extends WordQuestionSide {
  const _OriginSide() : super._();

  @override
  String question(Word word) => word.origin;
  @override
  String variant(Word word) => word.translation;
}

class _TranslationSide extends WordQuestionSide {
  const _TranslationSide() : super._();

  @override
  String question(Word word) => word.translation;
  @override
  String variant(Word word) => word.origin;
}
