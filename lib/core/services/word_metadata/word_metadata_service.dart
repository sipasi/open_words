import 'package:open_words/core/data/entities/metadata/word_metadata.dart';
import 'package:open_words/core/data/repository/word_metadata_repository.dart';
import 'package:open_words/core/services/word_metadata/word_metadata_web_api.dart';

class WordMetadataService {
  final WordMetadataRepository _repository;
  final WordMetadataWebApi _api;

  WordMetadataService({
    required WordMetadataRepository repository,
    required WordMetadataWebApi api,
  }) : _repository = repository,
       _api = api;

  Future<WordMetadata?> localOrWeb(String word) async {
    var metadata = await _repository.byWord(word);

    if (metadata != null) {
      return metadata;
    }

    final metadataDraft = await _api.find(word);

    if (metadataDraft != null) {
      return await _repository.create(metadataDraft);
    }

    return null;
  }
}
