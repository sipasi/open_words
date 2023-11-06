import 'package:open_words/data/word/word.dart';

class ChooseResult {
  final Word question;
  final Word answer;
  final bool correct;

  const ChooseResult({
    required this.question,
    required this.answer,
    required this.correct,
  });
}
