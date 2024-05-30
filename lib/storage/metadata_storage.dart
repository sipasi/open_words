import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/storage/entity_storage_async.dart';

abstract class MetadataStorage extends EntityStorageAsync<int, WordMetadata> {
  Future<WordMetadata?> firstByWord(String word);
}
