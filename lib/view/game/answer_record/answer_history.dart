import 'package:open_words/view/game/answer_record/answer_record.dart';

class ReadonlyHistory {
  final List<AnswerRecord> _results;

  int get length => _results.length;

  AnswerRecord operator [](int index) => _results[index];

  ReadonlyHistory() : _results = [];

  Iterator<AnswerRecord> get iterator => _results.iterator;
}

class AnswerHistory extends ReadonlyHistory {
  void add(AnswerRecord result) => _results.add(result);

  void clear() => _results.clear();
}
