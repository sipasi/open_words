import 'package:open_words/storage/metadata_storage.dart';
import 'package:open_words/storage/sembast/sembast_helper.dart';
import 'package:open_words/storage/sembast/sembast_metadata_storege.dart';
import 'package:open_words/storage/sembast/sembast_word_group_storege.dart';
import 'package:open_words/storage/word_group_storage.dart';

typedef StoragePair = (WordGroupStorage, MetadataStorage);

class StorageFactory {
  static Future<StoragePair> createDefault() => sembast();

  static Future<StoragePair> sembast([String name = 'open-words-sembast']) async {
    final database = await SembastHelper.openForCurrentPlatform(name);

    final groupStorege = SembastWordGroupStorege(database: database, name: 'word_group');
    final metadataStorege = SembastMetadataStorege(database: database, name: 'metadata');

    return (groupStorege, metadataStorege);
  }
}
