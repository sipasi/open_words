import 'package:open_words/core/data/draft/metadata/meaning_draft.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/mappers/definition_model_mapper.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/models/meaning_model.dart';

sealed class MeaningModelMapper {
  static MeaningDraft map(MeaningModel model) {
    return MeaningDraft(
      partOfSpeech: model.partOfSpeech!,
      definitions: DefinitionModelMapper.mapList(model.definitions),
      synonyms: model.synonyms,
      antonyms: model.antonyms,
    );
  }

  static List<MeaningDraft> mapList(List<MeaningModel> models) {
    return models.map(map).toList();
  }
}
