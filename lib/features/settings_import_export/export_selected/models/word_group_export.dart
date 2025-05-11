import 'dart:convert';

import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/features/settings_import_export/export_selected/models/word_export.dart';

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
      'name': name,
      'origin': origin.toMap(),
      'translation': translation.toMap(),
      'words': words.map((x) => x.toMap()).toList(),
    };
  }

  factory WordGroupExport.fromMap(Map<String, dynamic> map) {
    return WordGroupExport(
      name: map['name'] ?? '',
      origin: LanguageInfo.fromMap(map['origin']),
      translation: LanguageInfo.fromMap(map['translation']),
      words: List<WordExport>.from(
        map['words']?.map((x) => WordExport.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WordGroupExport.fromJson(String source) =>
      WordGroupExport.fromMap(json.decode(source));
}
