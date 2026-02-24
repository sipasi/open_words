import 'dart:convert';

import 'package:open_words/core/data/draft/metadata/word_metadata_draft.dart';
import 'package:open_words/core/data/draft/word_draft.dart';
import 'package:open_words/core/data/entities/metadata/word_metadata.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/settings/import_export/models/word_metadata_export.dart';

class WordExport {
  final String origin;
  final String translation;

  final WordMetadataExport metadata;

  WordExport({
    required this.origin,
    required this.translation,
    required this.metadata,
  });

  WordExport.from(Word word, WordMetadata metadata)
    : origin = word.origin.trim(),
      translation = word.translation.trim(),
      metadata = WordMetadataExport.from(metadata);

  Map<String, dynamic> toMap({bool ignoreMetadata = false}) {
    return {
      'origin': origin,
      'translation': translation,
      if (ignoreMetadata == false && metadata.isNotEmpty)
        'metadata': metadata.toMap(),
    };
  }

  factory WordExport.fromMap(Map<String, dynamic> map) {
    return WordExport(
      origin: map['origin'] ?? '',
      translation: map['translation'] ?? '',
      metadata: WordMetadataExport.fromMap(map['metadata'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory WordExport.fromJson(String source) =>
      WordExport.fromMap(json.decode(source));

  (WordDraft word, WordMetadataDraft metadata) asDraft() {
    return (
      WordDraft(origin: origin, translation: translation),
      metadata.asDraft(origin),
    );
  }
}
