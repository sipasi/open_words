import 'package:json_annotation/json_annotation.dart';

import 'package:open_words/data/metadata/definition.dart';

part 'meaning.g.dart';

@JsonSerializable(explicitToJson: true)
class Meaning {
  final String partOfSpeech;

  final List<Definition> definitions;

  final List<String> synonyms;

  final List<String> antonyms;

  Meaning({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) =>
      _$MeaningFromJson(json);

  Map<String, dynamic> toJson() => _$MeaningToJson(this);
}
