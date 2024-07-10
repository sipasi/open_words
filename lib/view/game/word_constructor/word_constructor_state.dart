import 'package:flutter/material.dart';
import 'package:open_words/collection/list_randomizer.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/word_constructor/part_list.dart';

class WordConstructorState {
  final Word _word;

  final AnswerPartList _answers;
  final VariantPartList _variants;

  PartList get answers => _answers;
  PartList get variants => _variants;

  String get question => _word.translation;
  String get answer => _word.origin;

  String get constructedText => _answers.constructed;

  bool get matched => _answers.matchWith(answer);
  bool get constructed => variants.length == answers.length;

  WordConstructorState._(this._word, List<String> parts)
      : _answers = AnswerPartList([]),
        _variants = VariantPartList(parts);

  factory WordConstructorState.byOneLetter(Word word) {
    final question = _toLowerCase(word);

    return WordConstructorState._(word, question.origin.characters.toList());
  }
  factory WordConstructorState.byTwoLetter(Word word, {bool shuffle = true}) {
    final question = _toLowerCase(word);

    final parts = <String>[];

    final length = question.origin.length;

    for (var i = 0; i < length;) {
      if (i + 2 <= length) {
        final part = question.origin.substring(i, i + 2);

        parts.add(part);

        i += 2;

        continue;
      }
      final part = question.origin.substring(i, i + 1);

      parts.add(part);

      i++;
    }

    if (shuffle) {
      parts.randomize(times: 5);
    }

    return WordConstructorState._(word, parts);
  }

  void onAnswerTap(int id) {
    _answers.remove(id);
    _variants.enableBy(id);
  }

  void onVariantTap(int id) {
    _variants.disableBy(id);

    _answers.add(_variants.enabledCopyBy(id));

    if (_variants.allDisabled == false) {
      return;
    }

    if (matched == false) {
      return;
    }
  }

  static Word _toLowerCase(Word word) {
    return Word(
      origin: word.origin.toLowerCase(),
      translation: word.translation.toLowerCase(),
    );
  }
}
