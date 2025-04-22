import 'package:open_words/core/data/draft/metadata/word_metadata_draft.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/mappers/metadata_model_mapper.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/metadata_model_joiner.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/models/word_metadata_model.dart';
import 'package:open_words/core/services/word_metadata/metadata_parcer.dart';

class DevDictionaryApiParcer extends MetadataParcer {
  @override
  WordMetadataDraft? parce(object) {
    final result = switch (object) {
      List<dynamic> list => _parceList(list),
      Map<String, dynamic> map => _parceSingle(map),
      _ => null,
    };

    return MetadataModelMapper.map(result);
  }

  WordMetadataModel? _parceList(List<dynamic> list) {
    final metadatas = <WordMetadataModel>[];

    for (var map in list) {
      WordMetadataModel? metadata = _parceSingle(map);

      if (metadata == null) {
        continue;
      }

      metadatas.add(metadata);
    }

    return MetadataModelJoiner.join(metadatas);
  }

  WordMetadataModel? _parceSingle(Map<String, dynamic> map) {
    return WordMetadataModel.fromJson(map);
  }
}
