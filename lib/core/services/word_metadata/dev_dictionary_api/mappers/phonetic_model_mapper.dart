import 'package:open_words/core/collection/linq/distinct_by_extension.dart';
import 'package:open_words/core/data/draft/metadata/phonetic_draft.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/models/phonetic_model.dart';

sealed class PhoneticModelMapper {
  static PhoneticDraft map(PhoneticModel model) {
    return PhoneticDraft(value: model.text ?? '', audio: model.audio ?? '');
  }

  static List<PhoneticDraft> mapList(List<PhoneticModel> models) {
    return models
        .where((item) => item.audio?.isNotEmpty ?? false)
        .distinctBy((item) => item)
        .map(map)
        .toList();
  }
}
