import 'package:open_words/view/game/word_compare/compare_game_page.dart';
import 'package:open_words/view/game/word_compare/word_text_getter.dart';

class OriginToTranslationPage extends CompareGamePage {
  const OriginToTranslationPage({
    super.key,
    super.textGetter = WordTextGetter.origin,
    required super.group,
  });
}
