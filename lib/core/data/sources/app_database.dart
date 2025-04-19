import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

abstract class AppDatabase {
  Future clear();
}

class AppDatabaseImpl extends AppDatabase {
  AppDriftDatabase database;

  AppDatabaseImpl(this.database);

  @override
  Future clear() async {
    for (var table in database.allTables) {
      await database.delete(table).go();
    }
  }
}
