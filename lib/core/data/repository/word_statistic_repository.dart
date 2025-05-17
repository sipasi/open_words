import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/game/word_statistic.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/repository/mappers/word_sql_mapper.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';
import 'package:open_words/core/data/sources/drift/tables/word_statistics_query.dart';

sealed class WordStatisticRepository {
  Future<WordStatistic?> getByWord(String word);

  Future addDependsTo(String word, bool isCorrect);

  Future addCorrectTo(String word);
  Future addIncorrectTo(String word);

  Future<List<Word>> getWithFewerAttempts(String word, int count);
}

class WordStatisticRepositoryImpl extends WordStatisticRepository {
  final AppDriftDatabase database;

  WordStatisticRepositoryImpl(this.database);

  @override
  Future addDependsTo(String word, bool isCorrect) {
    return isCorrect ? addCorrectTo(word) : addIncorrectTo(word);
  }

  @override
  Future addCorrectTo(String word) {
    return updateByWord(word, correct: true);
  }

  @override
  Future addIncorrectTo(String word) {
    return updateByWord(word, incorrect: true);
  }

  @override
  Future<WordStatistic?> getByWord(String word) {
    return database.managers.wordStatistics
        .filter((f) => f.word.equals(word))
        .map(
          (item) => WordStatistic(
            word: item.word,
            answerCorrect: item.correct,
            answerIncorrect: item.incorrect,
          ),
        )
        .getSingleOrNull();
  }

  @override
  Future<List<Word>> getWithFewerAttempts(String word, int count) {
    return database
        .getWithFewerAttempts(word, count)
        .map(WordSqlMapper.from)
        .get();
  }

  Future updateByWord(
    String word, {
    bool correct = false,
    bool incorrect = false,
  }) async {
    if (correct == false && incorrect == false) {
      return;
    }

    final stats = await ensureExist(word);

    final correctValue = correct ? stats.answerCorrect + 1 : null;
    final incorrectValue = incorrect ? stats.answerIncorrect + 1 : null;

    await database.managers.wordStatistics
        .filter((f) => f.word.equals(word))
        .update(
          (o) => o(
            correct: Value.absentIfNull(correctValue),
            incorrect: Value.absentIfNull(incorrectValue),
          ),
        );
  }

  Future<WordStatistic> ensureExist(String word) async {
    final stats = await getByWord(word);

    if (stats != null) {
      return stats;
    }

    await database.managers.wordStatistics.create(
      (o) => o(word: word, correct: 0, incorrect: 0),
    );

    return (await getByWord(word))!;
  }
}
