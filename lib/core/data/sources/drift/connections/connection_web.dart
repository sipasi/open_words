import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:logger/logger.dart';

QueryExecutor createExecutor(String name) {
  return DatabaseConnection.delayed(
    Future(() async {
      final result = await WasmDatabase.open(
        databaseName: name,
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.dart.js'),
      );

      if (result.missingFeatures.isNotEmpty) {
        Logger().e(
          'Using ${result.chosenImplementation} due to missing browser\n'
          '  features: ${result.missingFeatures}',
        );
      }

      return result.resolvedExecutor;
    }),
  );
}
