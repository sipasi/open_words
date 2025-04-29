import 'package:drift/drift.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class WordWebLookupRepository {
  Future<bool> wasBefore(String word);

  Future addAttempt(String word);
}

final class WordWebLookupRepositoryImpl extends WordWebLookupRepository {
  final AppDriftDatabase database;

  WordWebLookupRepositoryImpl(this.database);

  @override
  Future<bool> wasBefore(String word) {
    return database.managers.wordMetadataWebLookups
        .filter((f) => f.word.equals(word))
        .exists();
  }

  @override
  Future addAttempt(String word) async {
    var exist =
        await database.managers.wordMetadataWebLookups
            .filter((f) => f.word.equals(word))
            .getSingleOrNull();

    final now = DateTime.now();

    if (exist == null) {
      await database.managers.wordMetadataWebLookups.create(
        (o) => o(word: word, firstAttemp: now, lastAttemp: now, attemps: 1),
      );

      return;
    }

    await database.managers.wordMetadataWebLookups.update(
      (o) => o(lastAttemp: Value(now), attemps: Value(exist.attemps + 1)),
    );
  }
}
