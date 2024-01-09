import 'dart:async' show Future;
import 'package:flutter/foundation.dart';
import 'package:open_words/storage/in_memory_storage_helper.dart';
import 'package:open_words/storage/metadata_storage.dart';
import 'package:open_words/storage/sembast/sembast_helper.dart';
import 'package:open_words/storage/sembast/sembast_metadata_storege.dart';
import 'package:open_words/storage/sembast/sembast_word_group_storege.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:sembast_web/sembast_web.dart';

typedef StoragePair = (WordGroupStorage, MetadataStorage);

class StorageFactory {
  static Future<StoragePair> createSembast() async {
    final databaseFuture = kIsWeb ? databaseFactoryWeb.openDatabase('open_words_web') : SembastHelper.openDatabase();

    final database = await databaseFuture;

    final groupStorege = SembastWordGroupStorege(database: database, name: 'word_group');
    final metadataStorege = SembastMetadataStorege(database: database, name: 'metadata');

    return (groupStorege, metadataStorege);
  }

  static Future<StoragePair> createInMemory() async {
    final groupStorege = await InMemoryStorageHelper.createWordGroup();
    final metadataStorege = InMemoryStorageHelper.createMetadata();

    return (groupStorege, metadataStorege);
  }

  static Future<StoragePair> createDefault() => createSembast();
}
