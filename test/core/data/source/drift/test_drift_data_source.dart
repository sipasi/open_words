// test/helpers/test_database.dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

class TestDriftDataSource extends AppDriftDatabase {
  TestDriftDataSource() : super(_openTestDb());

  static LazyDatabase _openTestDb() {
    return LazyDatabase(() async {
      return NativeDatabase.memory();
    });
  }
}
