import 'package:open_words/view/game/word_compare/word_compare_game_page.dart';

class OriginToTranslationPage extends WordCompareGamePage {
  OriginToTranslationPage({
    super.key,
    required super.group,
  }) : super(
          questionText: (word) => word.origin,
          answerText: (word) => word.translation,
        );
}
