import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/word_list_random_extension.dart';

class WordCompareTool {
  static List<String> helpersFrom(
    WordMetadata? metadata, {
    int definitionCount = 2,
    int synonymsCount = 2,
    int antonymsCount = 2,
  }) {
    if (metadata == null) {
      return List.empty();
    }

    final definitions = metadata.meanings
        .expand((element) => element.definitions.map((e) => e.value))
        .toList(growable: false)
      ..shuffle();

    final synonyms = metadata.meanings.expand((element) => element.synonyms).toList(growable: false)..shuffle();

    final antonyms = metadata.meanings.expand((element) => element.antonyms).toList(growable: false)..shuffle();

    final helpers = <String>[];

    helpers.addAll(definitions.take(definitionCount));
    helpers.addAll(synonyms.take(synonymsCount));
    helpers.addAll(antonyms.take(antonymsCount));

    helpers.shuffle();

    return helpers;
  }
}
