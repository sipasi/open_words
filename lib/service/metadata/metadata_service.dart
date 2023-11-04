import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/service/metadata/metadata_web_finder.dart';
import 'package:open_words/storage/metadata_storage.dart';

class MetadataService {
  final MetadataStorage _storage;
  final MetadataWebFinder _webService;

  MetadataService({
    required MetadataStorage storage,
    required MetadataWebFinder webFinder,
  })  : _storage = storage,
        _webService = webFinder;

  Future<WordMetadata?> localOrWeb(String word) async {
    var metadata = await _storage.getBy(word);

    if (metadata != null) {
      return metadata;
    }

    metadata = await _webService.find(word);

    if (metadata != null) {
      _storage.set(word, metadata);
    }

    return metadata;
  }
}
