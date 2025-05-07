import 'package:open_words/features/game/shared/history/answer_record.dart';

class AnswerHistory {
  final List<AnswerRecord> _results;

  AnswerRecord? get lastOrNull => _results.lastOrNull;

  const AnswerHistory(this._results);
  const AnswerHistory.empty() : _results = const [];

  int get length => _results.length;

  AnswerRecord at(int index) => _results[index];
  AnswerRecord operator [](int index) => _results[index];

  AnswerHistory add(AnswerRecord result) =>
      copyWith(results: [..._results, result]);

  AnswerHistory copyWith({List<AnswerRecord>? results}) {
    return AnswerHistory(results ?? _results);
  }
}
