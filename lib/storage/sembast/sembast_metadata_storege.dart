import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/storage/metadata_storage.dart';
import 'package:open_words/storage/sembast/sembast_base_storage.dart';

class SembastMetadataStorege extends SembastBaseStorage<WordMetadata> implements MetadataStorage {
  SembastMetadataStorege({required super.database, required super.name});

  @override
  WordMetadata fromJson(Map<String, dynamic> json) => WordMetadata.fromJson(json);

  @override
  Map<String, dynamic> toJson(WordMetadata entity) => entity.toJson();
}
