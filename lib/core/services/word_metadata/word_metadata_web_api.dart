import 'package:open_words/core/data/draft/metadata/word_metadata_draft.dart';

abstract class WordMetadataWebApi {
  Future<WordMetadataDraft?> find(String word);
}
