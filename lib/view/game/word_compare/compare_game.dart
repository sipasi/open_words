import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:open_words/collection/readonly_list.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/storage/metadata_storage.dart';
import 'package:open_words/view/game/word_compare/choose_result.dart';
import 'package:open_words/view/game/word_compare/compare_data.dart';
import 'package:open_words/view/game/word_compare/compare_score.dart';
import 'package:open_words/view/game/word_compare/helper_text_list.dart';
import 'package:open_words/view/game/word_compare/word_text_getter.dart';

class CompareHistory extends IReadonlyList<ChooseResult> {
  final List<ChooseResult> _results;

  @override
  int get length => _results.length;
  @override
  ChooseResult operator [](int index) => _results[index];

  CompareHistory() : _results = [];

  void add({required Word question, required Word answer, required bool correct}) => _results.add(ChooseResult(
        question: question,
        answer: answer,
        correct: correct,
      ));

  void clear() => _results.clear();

  @override
  Iterator<ChooseResult> get iterator => _results.iterator;
}

class CompareGame {
  final Logger _logger = GetIt.I.get();

  final CompareHistory _history;

  late CompareData _data;

  int _current;

  final HelperTextList helpers;

  final CompareScore score;

  final List<Word> words;

  final WordTextGetter textGetter;

  CompareData get data => _data;

  IReadonlyList<ChooseResult> get history => _history;

  bool get gameEnd => _history.length == words.length;

  final MetadataStorage metadataStorage;

  void Function() onGameEnd;
  void Function() onMetadataLoaded;

  CompareGame({
    required this.words,
    required this.textGetter,
    required this.onGameEnd,
    required this.onMetadataLoaded,
    required this.metadataStorage,
  })  : _current = 0,
        _history = CompareHistory(),
        helpers = HelperTextList(),
        score = CompareScore(words.length);

  void start() {
    _current = 0;
    _history.clear();
    helpers.clear();
    score.clear();

    words.shuffle();

    next();
  }

  bool next() {
    if (gameEnd) {
      onGameEnd();

      return false;
    }

    _updateState();

    return true;
  }

  ChooseResult tryAnwser(Word answer) {
    final question = _data.question;

    bool correct = textGetter.question(question) == textGetter.question(answer);

    score.answer(correct);

    ChooseResult result = ChooseResult(question: question, answer: answer, correct: correct);

    _history.add(question: question, answer: answer, correct: correct);

    return result;
  }

  CompareData _createState() {
    return CompareData.create(words, _current, textGetter);
  }

  void _updateState() {
    _data = _createState();

    loadMetadataAndSetHelpers();

    _current++;
  }

  Future loadMetadataAndSetHelpers() {
    return Future(() async {
      final cache = _data;

      final metadata = await metadataStorage.firstByWord(data.question.origin);

      if (metadata == null) {
        return;
      }

      if (data != cache) {
        _logger.e('Differen cache.\nLook for ${cache.question.toJson()} but current ${data.question.toJson()}');
        return;
      }

      helpers.fillFrom(metadata);

      onMetadataLoaded();
    });
  }
}
