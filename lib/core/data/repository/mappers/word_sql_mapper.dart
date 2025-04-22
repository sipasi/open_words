import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class WordSqlMapper {
  static Word from(QueryRow row) {
    final data = row.data;

    return Word(
      id: Id.exist(data['id']),
      groupId: Id.exist(data['group_id']),
      origin: data['origin'],
      translation: data['translation'],
    );
  }

  static Insertable<DriftWord> toCreate({
    required Id groupId,
    required String origin,
    required String translation,
  }) {
    final now = DateTime.now();

    return WordsCompanion.insert(
      groupId: groupId.valueOrThrow(),
      created: now,
      origin: origin,
      translation: translation,
    );
  }

  static Insertable<DriftWord> toUpdate({
    Id? groupId,
    String? origin,
    String? translation,
  }) {
    return WordsCompanion(
      groupId: Value.absentIfNull(groupId?.valueOrThrow()),
      origin: Value.absentIfNull(origin),
      translation: Value.absentIfNull(translation),
    );
  }
}
