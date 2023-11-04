import 'package:open_words/data/word/word.dart';

abstract class WordTextGetter {
  static final WordTextGetter origin = _OriginTextGetter();
  static final WordTextGetter translation = _TranslationTextGetter();

  String question(Word word);
  String answer(Word word);
}

class _OriginTextGetter extends WordTextGetter {
  @override
  String question(Word word) => word.origin;
  @override
  String answer(Word word) => word.translation;
}

class _TranslationTextGetter extends WordTextGetter {
  @override
  String question(Word word) => word.translation;
  @override
  String answer(Word word) => word.origin;
}
