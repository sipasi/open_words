import 'package:open_words/data/metadata/word_metadata.dart';

abstract class WordMetadataWebApi {
  Future<WordMetadata?> find(String word);
}
