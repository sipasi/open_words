import 'dart:convert';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/json/json_parcer.dart';

class WordGroupJsonParcer extends JsonParcer<List<WordGroup>> {
  final converter = _WordGroupJsonConverter();

  @override
  List<WordGroup> from(String text) {
    final decoded = json.decode(text);

    if (decoded is List<dynamic>) {
      final result = decoded.map((item) => converter.from(item));

      return result.toList();
    }
    if (decoded is Map<String, dynamic>) {
      return [converter.from(decoded)];
    }

    return List.empty();
  }

  @override
  String to(List<WordGroup> entity) {
    final list = entity.map(converter.to).toList();

    return jsonEncode(list);
  }
}

abstract class _JsonConverter<T> {
  Map<String, dynamic> to(T entity);
  T from(Map<String, dynamic> map);
}

class _WordGroupJsonConverter extends _JsonConverter<WordGroup> {
  final wordConverter = _WordJsonConverter();

  @override
  WordGroup from(Map<String, dynamic> map) {
    final now = DateTime.now();

    return WordGroup(
      created: now,
      modified: now,
      name: map['name'] as String,
      origin: LanguageInfo.fromJson(map['origin'] as Map<String, dynamic>),
      translation: LanguageInfo.fromJson(map['translation'] as Map<String, dynamic>),
      words: _wordsFromJson(map['words']),
    );
  }

  @override
  Map<String, dynamic> to(WordGroup entity) {
    return <String, dynamic>{
      'name': entity.name,
      'origin': entity.origin.toJson(),
      'translation': entity.translation.toJson(),
      'words': entity.words.map(wordConverter.to).toList(),
    };
  }

  List<Word> _wordsFromJson(dynamic node) {
    return switch (node) {
      List<dynamic> list => list.map((item) => wordConverter.from(item)).toList(),
      Map<String, dynamic> map => [wordConverter.from(map)],
      _ => List.empty(growable: true),
    };
  }
}

class _WordJsonConverter extends _JsonConverter<Word> {
  @override
  Word from(Map<String, dynamic> map) {
    return Word(
      origin: map['origin'],
      translation: map['translation'],
    );
  }

  @override
  Map<String, dynamic> to(Word entity) {
    return <String, dynamic>{
      'origin': entity.origin,
      'translation': entity.translation,
    };
  }
}
