import 'package:open_words/core/collection/linq/group_by_extension.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/models/meaning_model.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/models/word_metadata_model.dart';

extension MetadataModelMerger on WordMetadataModel? {
  WordMetadataModel? merge() {
    if (this == null) {
      return null;
    }

    return WordMetadataModel(
      word: this!.word,
      etymology: this!.etymology,
      phonetics: this!.phonetics,
      meanings: _meanings(this!.meanings),
    );
  }

  static List<MeaningModel> _meanings(List<MeaningModel> meanings) {
    return meanings
        .groupBy((item) => item.partOfSpeech!)
        .entries
        .map(
          (e) => MeaningModel(
            partOfSpeech: e.key,
            definitions:
                e.value.expand((element) => element.definitions).toList(),
            synonyms: e.value.expand((element) => element.synonyms).toList(),
            antonyms: e.value.expand((element) => element.antonyms).toList(),
          ),
        )
        .toList();
  }
}
