import 'package:json_annotation/json_annotation.dart';
import 'package:open_words/data/language_info.dart';

import 'word.dart';

part 'word_group.g.dart';

@JsonSerializable(explicitToJson: true)
class WordGroup {
  final int? id;

  final DateTime created;
  final DateTime modified;

  final String name;

  final LanguageInfo origin;
  final LanguageInfo translation;

  final List<Word> words;

  const WordGroup({
    required this.created,
    required this.modified,
    required this.name,
    required this.origin,
    required this.translation,
    required this.words,
    this.id,
  });

  factory WordGroup.fromJson(Map<String, dynamic> json) => _$WordGroupFromJson(json);

  Map<String, dynamic> toJson() => _$WordGroupToJson(this);

  WordGroup copyWith({
    int? id,
    DateTime? created,
    DateTime? modified,
    String? name,
    LanguageInfo? origin,
    LanguageInfo? translation,
    List<Word>? words,
  }) {
    return WordGroup(
      id: id ?? this.id,
      created: created ?? this.created,
      modified: modified ?? this.modified,
      name: name ?? this.name,
      origin: origin ?? this.origin,
      translation: translation ?? this.translation,
      words: words ?? this.words.toList(),
    );
  }

  WordGroup clone() {
    return WordGroup(
      id: id,
      created: created,
      modified: modified,
      name: name,
      origin: origin,
      translation: translation,
      words: words.toList(),
    );
  }
}
