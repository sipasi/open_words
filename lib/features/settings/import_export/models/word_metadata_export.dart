import 'dart:convert';

import 'package:open_words/core/data/draft/metadata/definition_draft.dart';
import 'package:open_words/core/data/draft/metadata/meaning_draft.dart';
import 'package:open_words/core/data/draft/metadata/phonetic_draft.dart';
import 'package:open_words/core/data/draft/metadata/word_metadata_draft.dart';
import 'package:open_words/core/data/entities/metadata/definition.dart';
import 'package:open_words/core/data/entities/metadata/meaning.dart';
import 'package:open_words/core/data/entities/metadata/phonetic.dart';
import 'package:open_words/core/data/entities/metadata/word_metadata.dart';

class WordMetadataExport {
  final String etymology;
  final List<PhoneticExport> phonetics;
  final List<MeaningExport> meanings;

  bool get isEmpty =>
      etymology.isEmpty && phonetics.isEmpty && meanings.isEmpty;
  bool get isNotEmpty => !isEmpty;

  WordMetadataExport({
    required this.etymology,
    required this.phonetics,
    required this.meanings,
  });

  const WordMetadataExport.empty()
    : etymology = '',
      phonetics = const [],
      meanings = const [];

  WordMetadataExport.from(WordMetadata metadata)
    : etymology = metadata.etymology,
      phonetics = metadata.phonetics.map(PhoneticExport.from).toList(),
      meanings = metadata.meanings.map(MeaningExport.from).toList();

  Map<String, dynamic> toMap() {
    return {
      'etymology': etymology,
      'phonetics': phonetics.map((x) => x.toMap()).toList(),
      'meanings': meanings.map((x) => x.toMap()).toList(),
    };
  }

  factory WordMetadataExport.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return const .empty();
    }

    return WordMetadataExport(
      etymology: map['etymology'] ?? '',
      phonetics: List<PhoneticExport>.from(
        map['phonetics']?.map((x) => PhoneticExport.fromMap(x)),
      ),
      meanings: List<MeaningExport>.from(
        map['meanings']?.map((x) => MeaningExport.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WordMetadataExport.fromJson(String source) =>
      WordMetadataExport.fromMap(json.decode(source));

  WordMetadataDraft asDraft(String origin) {
    return WordMetadataDraft(
      word: origin,
      etymology: etymology,
      phonetics: phonetics.map((e) => e.asDraft()).toList(),
      meanings: meanings.map((e) => e.asDraft()).toList(),
    );
  }
}

class PhoneticExport {
  final String value;
  final String audio;

  PhoneticExport({
    required this.value,
    required this.audio,
  });
  PhoneticExport.from(Phonetic phonetic)
    : value = phonetic.value,
      audio = phonetic.audio;

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'audio': audio,
    };
  }

  factory PhoneticExport.fromMap(Map<String, dynamic> map) {
    return PhoneticExport(
      value: map['value'] ?? '',
      audio: map['audio'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneticExport.fromJson(String source) =>
      PhoneticExport.fromMap(json.decode(source));

  PhoneticDraft asDraft() {
    return PhoneticDraft(value: value, audio: audio);
  }
}

class MeaningExport {
  final String partOfSpeech;

  final List<DefinitionExport> definitions;

  final List<String> synonyms;

  final List<String> antonyms;

  MeaningExport({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });
  MeaningExport.from(Meaning meaning)
    : partOfSpeech = meaning.partOfSpeech,
      definitions = meaning.definitions.map(DefinitionExport.from).toList(),
      synonyms = meaning.synonyms.toList(),
      antonyms = meaning.antonyms.toList();

  Map<String, dynamic> toMap() {
    return {
      'partOfSpeech': partOfSpeech,
      'definitions': definitions.map((x) => x.toMap()).toList(),
      'synonyms': synonyms,
      'antonyms': antonyms,
    };
  }

  factory MeaningExport.fromMap(Map<String, dynamic> map) {
    return MeaningExport(
      partOfSpeech: map['partOfSpeech'] ?? '',
      definitions: List<DefinitionExport>.from(
        map['definitions']?.map((x) => DefinitionExport.fromMap(x)),
      ),
      synonyms: List<String>.from(map['synonyms']),
      antonyms: List<String>.from(map['antonyms']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MeaningExport.fromJson(String source) =>
      MeaningExport.fromMap(json.decode(source));

  MeaningDraft asDraft() {
    return MeaningDraft(
      partOfSpeech: partOfSpeech,
      antonyms: antonyms.toList(),
      synonyms: synonyms.toList(),
      definitions: definitions
          .map((e) => DefinitionDraft(value: e.value, example: e.example))
          .toList(),
    );
  }
}

class DefinitionExport {
  final String value;
  final String example;

  DefinitionExport({
    required this.value,
    required this.example,
  });
  DefinitionExport.from(Definition definition)
    : value = definition.value,
      example = definition.example;

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'example': example,
    };
  }

  factory DefinitionExport.fromMap(Map<String, dynamic> map) {
    return DefinitionExport(
      value: map['value'] ?? '',
      example: map['example'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DefinitionExport.fromJson(String source) =>
      DefinitionExport.fromMap(json.decode(source));
}
