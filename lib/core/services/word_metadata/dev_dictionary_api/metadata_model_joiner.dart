import 'package:open_words/core/services/word_metadata/dev_dictionary_api/models/word_metadata_model.dart';

sealed class MetadataModelJoiner {
  static WordMetadataModel? join(List<WordMetadataModel> list) {
    if (list.isEmpty) {
      return null;
    }

    if (list.length == 1) {
      return list[0];
    }

    return WordMetadataModel(
      word: list[0].word,
      origin: list
          .map((e) => e.origin)
          .firstWhere((element) => element != null, orElse: () => null),
      phonetic: list
          .map((e) => e.phonetic)
          .firstWhere((element) => element != null, orElse: () => null),
      phonetics: list.expand((e) => e.phonetics).toList(),
      meanings: list.expand((e) => e.meanings).toList(),
    );
  }
}
