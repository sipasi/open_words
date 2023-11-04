import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/word_compare/word_text_getter.dart';
import 'package:open_words/view/game/word_list_random_extension.dart';

class CompareScore {
  int _correct = 0;
  int _wrong = 0;
  int _answered = 0;

  int get correct => _correct;
  int get wrong => _wrong;
  int get answered => _answered;

  void answerCorrect() {
    _answered++;
    _correct++;
  }

  void answerWrong() {
    _answered++;
    _wrong++;
  }

  void answer(bool correct) => correct ? answerCorrect() : answerWrong();
}

class WordCompareGame {
  final List<ChooseResult> _results = [];

  late CompareData _data;

  int _current = 0;

  final CompareScore score;

  final List<Word> words;
  final Map<Word, WordMetadata> metadatas;

  final WordTextGetter textGetter;

  CompareData get data => _data;

  bool get gameEnd => _results.length == words.length;

  WordCompareGame({
    required this.words,
    required this.metadatas,
    required this.textGetter,
  }) : score = CompareScore();

  void start() {
    _data = _createState();

    _current++;
  }

  bool next() {
    if (gameEnd) {
      return false;
    }

    _current++;

    _data = _createState();

    return true;
  }

  ChooseResult tryAnwser(Word answer) {
    final question = _data.question;

    bool correct = textGetter.question(question) == textGetter.question(answer);

    score.answer(correct);

    ChooseResult result = ChooseResult(question: question, answer: answer, correct: correct);

    _results.add(result);

    return result;
  }

  CompareData _createState() {
    return CompareData.create(words, _current, textGetter);
  }
}

class CompareData {
  final Word question;
  final List<Word> answers;

  CompareData({
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

class ChooseResult {
  final Word question;
  final Word answer;
  final bool correct;

  ChooseResult({
    required this.question,
    required this.answer,
    required this.correct,
  });
}
