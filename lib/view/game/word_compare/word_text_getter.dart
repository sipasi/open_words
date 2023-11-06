import 'package:open_words/data/word/word.dart';

abstract class WordTextGetter {
  static const WordTextGetter origin = _OriginTextGetter();
  static const WordTextGetter translation = _TranslationTextGetter();

  const WordTextGetter();

  String question(Word word);
  String answer(Word word);
}

class _OriginTextGetter extends WordTextGetter {
  const _OriginTextGetter();

  @override
  String question(Word word) => word.origin;
  @override
  String answer(Word word) => word.translation;
}

class _TranslationTextGetter extends WordTextGetter {
  const _TranslationTextGetter();

  @override
  String question(Word word) => word.translation;
  @override
  String answer(Word word) => word.origin;
}
