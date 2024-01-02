import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'text_editing_view_model.dart';

class WordListCreateViewModel {
  final List<Word> _created;

  final LanguageInfo originInfo;
  final LanguageInfo translationInfo;

  final int startIndex;

  final TextEditingViewModel origin;
  final TextEditingViewModel translation;

  int get length => _created.length;

  WordListCreateViewModel({
    required this.startIndex,
    required this.originInfo,
    required this.translationInfo,
  })  : _created = [],
        origin = TextEditingViewModel(controller: TextEditingController(), focusNode: FocusNode()),
        translation = TextEditingViewModel(controller: TextEditingController(), focusNode: FocusNode());

  Word get(int index) => _created[index];

  Future remove(int index, UpdateState updateState) async {
    await HapticFeedback.vibrate();

    updateState(() {
      _created.removeAt(index);
    });
  }

  void tryAdd(UpdateState updateState) {
    bool valid = validate(updateState);

    if (valid == false) {
      HapticFeedback.vibrate();

      return;
    }

    final index = startIndex + _created.length;

    final word = Word(
      index: index,
      origin: origin.text,
      translation: translation.text,
    );

    HapticFeedback.vibrate();

    updateState(() {
      _created.add(word);

      origin.clear();
      translation.clear();

      origin.setFocus();
    });
  }

  bool validate(UpdateState updateState) {
    updateState(() {
      origin.setError(origin.isEmpty ? 'Can\'t save while origin is empty' : null);
      translation.setError(translation.isEmpty ? 'Can\'t save while translation is empty' : null);
    });

    if (origin.isEmpty || translation.isEmpty) {
      return false;
    }

    return true;
  }

  Future tryTranslate(UpdateState updateState) async {
    bool empty = origin.isEmptyOrWhiteSpace;

    updateState(() {
      origin.clearError();
    });

    if (empty) {
      HapticFeedback.vibrate();

      updateState(() {
        origin.setError('Can\'t open translator while origin is empty');
        origin.clear();
        origin.setFocus();
      });

      return;
    }

    final address = Uri.https(
      'translate.google.com',
      '/',
      {
        'sl': originInfo.code,
        'tl': translationInfo.code,
        'text': origin.textTrim,
        'op': 'translate',
      },
    );

    bool openedInApp = false;

    try {
      openedInApp = await launchUrl(address, mode: LaunchMode.externalNonBrowserApplication);
    } catch (e) {}

    if (openedInApp == false) {
      await launchUrl(address, mode: LaunchMode.platformDefault);
    }
  }

  List<Word> toList() {
    final list = _created
        .asMap()
        .entries
        .map((entry) => Word(
              origin: entry.value.origin,
              translation: entry.value.translation,
              index: entry.key,
            ))
        .toList();

    return list;
  }

  void dispose() {
    origin.dispose();
    translation.dispose();
  }
}
