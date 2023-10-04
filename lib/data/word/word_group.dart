import 'package:json_annotation/json_annotation.dart';
import 'package:open_words/data/language_info.dart';

import 'word.dart';

part 'word_group.g.dart';

@JsonSerializable()
class WordGroup {
  final String id;

  final DateTime created;
  final DateTime modified;

  final String name;

  final LanguageInfo origin;
  final LanguageInfo translation;

  final List<Word> words;

  final int index;

  const WordGroup({
    required this.id,
    required this.created,
    required this.modified,
    required this.name,
    required this.origin,
    required this.translation,
    required this.words,
    required this.index,
  });

  factory WordGroup.fromJson(Map<String, dynamic> json) => _$WordGroupFromJson(json);

  Map<String, dynamic> toJson() => _$WordGroupToJson(this);
}
