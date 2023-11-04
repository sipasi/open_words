import 'package:open_words/view/game/word_compare/word_compare_game_page.dart';

class TranslationToOriginPage extends WordCompareGamePage {
  TranslationToOriginPage({
    super.key,
    required super.group,
  }) : super(
          questionText: (word) => word.translation,
          answerText: (word) => word.origin,
        );
}
