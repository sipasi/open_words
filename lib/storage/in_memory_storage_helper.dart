import 'dart:async' show Future;
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/storage/build_in_loader.dart';
import 'package:open_words/storage/in_memory_word_group_storage.dart';

import 'in_memory_metadata_storage.dart';

class InMemoryStorageHelper {
  static Future<InMemoryWordGroupStorage> createWordGroup() async {
    final list = await _fromWordGroupBuiltIn();

    final storage = InMemoryWordGroupStorage();

    for (int i = 0; i < list.length; i++) {
      final group = list[i];

      storage.set(group.id, group);
    }

    return storage;
  }

  static InMemoryMetadataStorage createMetadata() {
    final storage = InMemoryMetadataStorage();

    return storage;
  }

  static Future<List<WordGroup>> _fromWordGroupBuiltIn() async {
    final buildInLoader = BuildInLoader();

    final list = await buildInLoader.load();

    return list;
  }
}
