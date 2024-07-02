import 'package:open_words/data/word/word.dart';

class PairData {
  final Word word;
  final String text;

  PairData.origin(this.word) : text = word.origin;
  PairData.translation(this.word) : text = word.translation;

  bool isOrigin() => word.origin == text;
  bool isTranslation() => word.translation == text;
}
