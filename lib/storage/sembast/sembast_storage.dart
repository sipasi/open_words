import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/storage/entity_storage_async.dart';

class SembastStorege extends EntityStorageAsync<String, WordGroup> {
  Future open() async {
    // File path to a file in the current directory
    String dbPath = 'sample.db';
    DatabaseFactory dbFactory = databaseFactoryIo;

// We use the database factory to open the database
    Database db = await dbFactory.openDatabase(dbPath);
  }

  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<WordGroup>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<WordGroup?> getBy(String id) {
    // TODO: implement getBy
    throw UnimplementedError();
  }

  @override
  Future<void> set(String id, WordGroup entity) {
    // TODO: implement set
    throw UnimplementedError();
  }
}
