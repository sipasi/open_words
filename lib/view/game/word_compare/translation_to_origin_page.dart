import 'package:open_words/view/game/word_compare/compare_game_page.dart';
import 'package:open_words/view/game/word_compare/word_text_getter.dart';

class TranslationToOriginPage extends CompareGamePage {
  const TranslationToOriginPage({
    super.key,
    super.textGetter = WordTextGetter.translation,
    required super.group,
  });
}
