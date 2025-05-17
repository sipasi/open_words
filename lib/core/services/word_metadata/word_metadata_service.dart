import 'package:open_words/core/data/entities/metadata/word_metadata.dart';
import 'package:open_words/core/data/repository/word_metadata_repository.dart';
import 'package:open_words/core/data/repository/word_web_lookup_repository.dart';
import 'package:open_words/core/services/word_metadata/word_metadata_web_api.dart';

class WordMetadataService {
  final WordWebLookupRepository _webLookup;
  final WordMetadataRepository _repository;
  final WordMetadataWebApi _api;

  WordMetadataService({
    required WordWebLookupRepository webLookup,
    required WordMetadataRepository repository,
    required WordMetadataWebApi api,
  }) : _webLookup = webLookup,
       _repository = repository,
       _api = api;

  Future<WordMetadata?> localOrWeb(
    String word, [
    bool ignoreAttempts = false,
  ]) async {
    var metadata = await _repository.byWord(word);

    if (metadata != null) {
      return metadata;
    }

    if (!ignoreAttempts && await _webLookup.wasBefore(word)) {
      return null;
    }

    final metadataDraft = await _api.find(word);

    await _webLookup.addAttempt(word);

    if (metadataDraft != null) {
      return await _repository.create(metadataDraft);
    }

    return null;
  }

  Future<WordMetadata?> localOnly(String word) {
    return _repository.byWord(word);
  }
}
