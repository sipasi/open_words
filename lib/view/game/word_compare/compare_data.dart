import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/word_compare/word_text_getter.dart';
import 'package:open_words/view/game/word_list_random_extension.dart';

class CompareData {
  final Word question;
  final List<Word> answers;

  const CompareData({
    required this.question,
    required this.answers,
  });

  static CompareData create(List<Word> words, int current, WordTextGetter textGetter) {
    final question = words[current];

    final answers = words.getRandom(count: 4, exclude: question);

    return CompareData(
      question: question,
      answers: answers,
    );
  }
}
