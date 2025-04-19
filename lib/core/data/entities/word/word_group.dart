import 'package:open_words/core/data/entities/entity.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/language_info.dart';

class WordGroup extends Entity {
  final Id folderId;

  final DateTime created;
  final DateTime modified;

  final String name;

  final LanguageInfo origin;
  final LanguageInfo translation;

  final int words;

  WordGroup({
    required super.id,
    required this.folderId,
    required this.created,
    required this.modified,
    required this.name,
    required this.origin,
    required this.translation,
    required this.words,
  });

  WordGroup copyWith({
    Id? folderId,
    DateTime? modified,
    String? name,
    LanguageInfo? origin,
    LanguageInfo? translation,
    int? words,
  }) {
    return WordGroup(
      id: id,
      folderId: folderId ?? this.folderId,
      created: created,
      modified: modified ?? this.modified,
      name: name ?? this.name,
      origin: origin ?? this.origin,
      translation: translation ?? this.translation,
      words: words ?? this.words,
    );
  }
}
