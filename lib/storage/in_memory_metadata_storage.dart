import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/storage/in_memory_storage.dart';
import 'package:open_words/storage/metadata_storage.dart';

class InMemoryMetadataStorage extends InMemoryStorage<WordMetadata> implements MetadataStorage {}
