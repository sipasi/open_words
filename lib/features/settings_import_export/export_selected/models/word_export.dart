import 'dart:convert';

import 'package:open_words/core/data/entities/word/word.dart';

class WordExport {
  final String origin;
  final String translation;

  WordExport({required this.origin, required this.translation});

  WordExport.from(Word word)
    : origin = word.origin,
      translation = word.translation;

  Map<String, dynamic> toMap() {
    return {'origin': origin, 'translation': translation};
  }

  factory WordExport.fromMap(Map<String, dynamic> map) {
    return WordExport(
      origin: map['origin'] ?? '',
      translation: map['translation'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WordExport.fromJson(String source) =>
      WordExport.fromMap(json.decode(source));
}
