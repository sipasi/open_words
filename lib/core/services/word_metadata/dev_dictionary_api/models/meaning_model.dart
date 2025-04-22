import 'package:open_words/core/services/word_metadata/dev_dictionary_api/models/definition_model.dart';

class MeaningModel {
  final String? partOfSpeech;
  final List<DefinitionModel> definitions;

  final List<String> synonyms;
  final List<String> antonyms;

  MeaningModel({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });

  factory MeaningModel.fromJson(Map<String, dynamic> json) {
    return MeaningModel(
      partOfSpeech: json["partOfSpeech"],
      definitions:
          json["definitions"] == null
              ? const []
              : List<DefinitionModel>.from(
                json["definitions"]!.map((x) => DefinitionModel.fromJson(x)),
              ),
      synonyms:
          json["synonyms"] == null
              ? const []
              : List<String>.from(json["synonyms"]!.map((x) => x)),
      antonyms:
          json["antonyms"] == null
              ? const []
              : List<String>.from(json["antonyms"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "partOfSpeech": partOfSpeech,
    "definitions": definitions.map((x) => x.toJson()).toList(),
    "synonyms": synonyms,
    "antonyms": antonyms,
  };
}
