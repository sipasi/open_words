import 'package:flutter/material.dart';
import 'package:open_words/collection/list_randomizer.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/guess_game/word_constructor/part_list.dart';
import 'package:open_words/view/game/guess_game/word_question_side.dart';
import 'package:open_words/view/game/guess_game/word_source.dart';

class ConstructorQuizItem extends QuizItem {
  final Word _word;

  final AnswerPartList _answers;
  final VariantPartList _variants;

  final WordQuestionSide _questionSide;

  PartList get answers => _answers;
  PartList get variants => _variants;

  String get question => _questionSide.variant(_word);
  String get answer => _questionSide.question(_word);

  String get constructedText => _answers.constructed;

  bool get matched => _answers.matchWith(answer);
  bool get constructed => variants.length == answers.length;

  @override
  bool get allSolved => constructed;

  ConstructorQuizItem._(this._word, List<String> parts, this._questionSide)
      : _answers = AnswerPartList([]),
        _variants = VariantPartList(parts);

  factory ConstructorQuizItem.byOneLetter(Word word, WordQuestionSide questionSide) {
    final lower = _toLowerCase(word);

    return ConstructorQuizItem._(
      lower,
      _StringCutter.byOneLetter(questionSide.question(lower)),
      questionSide,
    );
  }
  factory ConstructorQuizItem.byTwoLetter(Word word, WordQuestionSide questionSide, {bool shuffle = true}) {
    final lower = _toLowerCase(word);

    final question = questionSide.question(lower);

    final parts = _StringCutter.byTwoLetter(question);

    if (shuffle) {
      parts.randomize(times: 5);
    }

    return ConstructorQuizItem._(lower, parts, questionSide);
  }

  void onAnswerTap(int id) {
    _answers.remove(id);
    _variants.enableBy(id);
  }

  void onVariantTap(int id) {
    _variants.disableBy(id);

    _answers.add(_variants.enabledCopyBy(id));
  }

  @override
  void clear() {
    _answers.reset();
    _variants.enableAll();
  }

  static Word _toLowerCase(Word word) {
    return Word(
      origin: word.origin.toLowerCase(),
      translation: word.translation.toLowerCase(),
    );
  }
}

class _StringCutter {
  static List<String> byOneLetter(String text) {
    return text.characters.toList();
  }

  static List<String> byTwoLetter(String text) {
    const whiteSpace = ' ';
    const emptyString = '';

    List<String> parts = [];

    final length = text.length;

    for (var i = 0; i < length;) {
      if (i + 2 <= length) {
        final part = text.substring(i, i + 2);

        for (var element in part.split(whiteSpace)) {
          parts.add(element == emptyString ? whiteSpace : element);
        }

        i += 2;

        continue;
      }
      final part = text.substring(i, i + 1);

      parts.add(part);

      i++;
    }

    return parts;
  }
}
