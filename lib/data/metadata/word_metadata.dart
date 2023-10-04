import 'package:json_annotation/json_annotation.dart';

import 'meaning.dart';
import 'phonetic.dart';

part 'word_metadata.g.dart';

@JsonSerializable()
class WordMetadata {
  final String id;

  final String word;

  final List<Phonetic> phonetics;

  final List<Meaning> meanings;

  WordMetadata({
    required this.id,
    required this.word,
    required this.phonetics,
    required this.meanings,
  });

  factory WordMetadata.fromJson(Map<String, dynamic> json) =>
      _$WordMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$WordMetadataToJson(this);
}
