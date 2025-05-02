import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/draft/metadata/word_metadata_draft.dart';
import 'package:open_words/core/services/logger/app_logger.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/mappers/meaning_model_mapper.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/mappers/phonetic_model_mapper.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/models/word_metadata_model.dart';

extension MetadataModelMapper on WordMetadataModel? {
  WordMetadataDraft? map() {
    final model = this;

    if (model == null) {
      return null;
    }

    if ((model.word ?? '').isEmpty) {
      final logger = GetIt.I.get<AppLogger>();

      logger.w(
        '[MetadataModelMapper] - WordMetadataModel.word field was empty\nword: ${model.word}',
      );

      return null;
    }

    return WordMetadataDraft(
      word: model.word!,
      etymology: model.etymology ?? '',
      phonetics: PhoneticModelMapper.mapList(model.phonetics),
      meanings: MeaningModelMapper.mapList(model.meanings),
    );
  }
}
