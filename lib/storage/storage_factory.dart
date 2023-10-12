import 'dart:async' show Future;
import 'package:open_words/storage/in_memory_storage_helper.dart';
import 'package:open_words/storage/metadata_storage.dart';
import 'package:open_words/storage/sembast/sembast_helper.dart';
import 'package:open_words/storage/sembast/sembast_metadata_storege.dart';
import 'package:open_words/storage/sembast/sembast_word_group_storege.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:sembast/sembast.dart';

class StorageFactory {
  static Future<(WordGroupStorage, MetadataStorage)> createSembast() async {
    Database database = await SembastHelper.openDatabase();

    final groupStorege = SembastWordGroupStorege(database: database, name: 'word_group');
    final metadataStorege = SembastMetadataStorege(database: database, name: 'metadata');

    return (groupStorege, metadataStorege);
  }

  static Future<(WordGroupStorage, MetadataStorage)> createInMemory() async {
    final groupStorege = await InMemoryStorageHelper.createWordGroup();
    final metadataStorege = InMemoryStorageHelper.createMetadata();

    return (groupStorege, metadataStorege);
  }

  static Future<(WordGroupStorage, MetadataStorage)> createDefault() => createSembast();
}
