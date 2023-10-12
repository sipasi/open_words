import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/storage/sembast/sembast_base_storage.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:sembast/sembast.dart';

class SembastWordGroupStorege extends SembastBaseStorage<WordGroup> implements WordGroupStorage {
  SembastWordGroupStorege({required super.database, required super.name});

  @override
  WordGroup fromJson(Map<String, dynamic> json) => WordGroup.fromJson(json);

  @override
  Map<String, dynamic> toJson(WordGroup entity) => entity.toJson();

  @override
  Finder? getAllFinder() => Finder(sortOrders: [SortOrder('index')]);
}
