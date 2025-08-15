import 'dart:convert';

import 'package:open_words/core/data/draft/word_draft.dart';

class PreinstalledDictionary {
  final String originName;
  final String translationName;

  final List<WordDraft> words;

  PreinstalledDictionary({
    required this.originName,
    required this.translationName,
    required this.words,
  });

  factory PreinstalledDictionary.fromMap(Map<String, dynamic> map) {
    return PreinstalledDictionary(
      originName: map['origin-name'] as String,
      translationName: map['translation-name'] as String,
      words: (map['words'] as List<dynamic>)
          .map<WordDraft>(
            (e) => WordDraft(
              origin: e['origin'],
              translation: e['translation'],
            ),
          )
          .toList(),
    );
  }

  factory PreinstalledDictionary.fromJson(String source) =>
      PreinstalledDictionary.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
