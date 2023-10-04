import 'dart:async' show Future;
import 'dart:convert' as convert;
import 'package:flutter/services.dart' show rootBundle;

import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/storage/in_memory_storage.dart';
import 'package:open_words/storage/work_group_storage.dart';
import 'package:uuid/uuid.dart';

class InMemoryWordGroupStorage extends InMemoryStorage<WordGroup>
    implements WorkGroupStorage {
  static Future<InMemoryWordGroupStorage> fromBuiltIn() async {
    final buildInLoader = BuildInLoader();

    final list = await buildInLoader.load();

    final storage = InMemoryWordGroupStorage();

    for (int i = 0; i < list.length; i++) {
      final group = list[i];

      storage.set(group.id, group);
    }

    return storage;
  }
}

class BuildInLoader {
  final uuid = const Uuid();
  final created = DateTime.now().toIso8601String();

  Future<List<WordGroup>> load() async {
    String raw =
        await rootBundle.loadString('assets/json/build_in_dictionaries.json');

    final list = convert.json.decode(raw) as List<dynamic>;

    final result = <WordGroup>[];

    for (int i = 0; i < list.length; i++) {
      final map = list[i];

      setWordGroupProperties(map, i);

      WordGroup group = WordGroup.fromJson(map);

      result.add(group);
    }

    return result;
  }

  void setWordGroupProperties(dynamic map, int index) {
    map['id'] = uuid.v1();

    map['created'] = created;
    map['modified'] = created;
    map['index'] = index;

    setWordsProperties(map['words']);
  }

  void setWordsProperties(List<dynamic> words) {
    for (var i = 0; i < words.length; i++) {
      final word = words[i];

      word['index'] = i;
    }
  }
}
