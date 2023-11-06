import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/view/game/word_compare/helper_text.dart';

class WordCompareTool {
  static List<HelperText> helpersFrom(
    WordMetadata? metadata, {
    int definitionCount = 2,
    int synonymsCount = 2,
    int antonymsCount = 2,
  }) {
    if (metadata == null) {
      return List.empty();
    }

    final definitions = metadata.meanings
        .expand((element) => element.definitions.map((e) => HelperText(
              prefix: 'definition',
              text: e.value,
            )))
        .toList(growable: false)
      ..shuffle();

    final synonyms = metadata.meanings
        .expand((element) => element.synonyms)
        .map((e) => HelperText(prefix: 'synonym', text: e))
        .toList(growable: false)
      ..shuffle();

    final antonyms = metadata.meanings
        .expand((element) => element.antonyms)
        .map((e) => HelperText(prefix: 'antonym', text: e))
        .toList(growable: false)
      ..shuffle();

    final helpers = <HelperText>[];

    helpers.addAll(definitions.take(definitionCount));
    helpers.addAll(synonyms.take(synonymsCount));
    helpers.addAll(antonyms.take(antonymsCount));

    helpers.shuffle();

    return helpers;
  }
}
