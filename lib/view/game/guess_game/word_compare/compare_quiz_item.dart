import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/guess_game/word_question_side.dart';
import 'package:open_words/view/game/guess_game/word_source.dart';

class CompareQuizItem extends QuizItem {
  bool _solved;

  final WordQuestionSide _side;

  final Word question;

  final List<Word> variants;

  @override
  bool get allSolved => _solved;

  CompareQuizItem(this._side, this.question, this.variants) : _solved = false;

  void markAsSolved() => _solved = true;

  String getQuestionText() => _side.question(question);
  String getCorrectAnswerText() => _side.variant(question);
  String getVariantTextAt(int index) => _side.variant(variants[index]);

  @override
  void clear() {
    _solved = false;
  }
}
