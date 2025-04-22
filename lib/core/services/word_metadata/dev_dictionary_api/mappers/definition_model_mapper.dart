import 'package:open_words/core/data/draft/metadata/definition_draft.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/models/definition_model.dart';

sealed class DefinitionModelMapper {
  static DefinitionDraft map(DefinitionModel model) {
    return DefinitionDraft(
      value: model.definition ?? '',
      example: model.example ?? '',
    );
  }

  static List<DefinitionDraft> mapList(List<DefinitionModel> models) {
    return models
        .where(
          (element) => element.definition != null || element.example != null,
        )
        .map(map)
        .toList();
  }
}
