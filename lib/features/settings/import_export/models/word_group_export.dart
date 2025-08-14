import 'dart:convert';

import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/features/settings/import_export/models/language_info_resolver.dart';
import 'package:open_words/features/settings/import_export/models/word_export.dart';
import 'package:open_words/features/settings/import_export/models/word_group_field.dart';

class WordGroupExport {
  final String name;

  final LanguageInfo origin;
  final LanguageInfo translation;

  final List<WordExport> words;

  WordGroupExport({
    required this.name,
    required this.origin,
    required this.translation,
    required this.words,
  });

  WordGroupExport.from(WordGroup group, this.words)
    : name = group.name,
      origin = group.origin,
      translation = group.translation;

  Map<String, dynamic> toMap() {
    return {
      WordGroupField.name.key: name,
      WordGroupField.origin.key: origin.toMap(),
      WordGroupField.translation.key: translation.toMap(),
      WordGroupField.words.key: words.map((x) => x.toMap()).toList(),
    };
  }

  factory WordGroupExport.fromMap({
    required LanguageInfoResolver languageResolver,
    required Map<String, dynamic> map,
  }) {
    return WordGroupExport(
      name: WordGroupField.name.fromMap(map) ?? '',
      origin: languageResolver.originFrom(map),
      translation: languageResolver.translationFrom(map),
      words: (WordGroupField.words.fromMap<List>(map) ?? const [])
          .map((x) => WordExport.fromMap(x))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WordGroupExport.fromJson({
    required LanguageInfoResolver resolver,
    required String source,
  }) => WordGroupExport.fromMap(
    languageResolver: resolver,
    map: json.decode(source),
  );
}
