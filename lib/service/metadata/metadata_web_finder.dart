import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/service/metadata/word_metadata_web_api.dart';

class MetadataWebFinder {
  final WordMetadataWebApi _web;

  MetadataWebFinder(this._web);

  Future<WordMetadata?> find(String word) async {
    return _web.find(word);
  }
}
