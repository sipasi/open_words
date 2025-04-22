import 'package:open_words/core/services/word_metadata/dev_dictionary_api/models/meaning_model.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/models/phonetic_model.dart';

class WordMetadataModel {
  final String? word;
  final String? origin;
  final String? phonetic;
  final List<PhoneticModel> phonetics;
  final List<MeaningModel> meanings;

  WordMetadataModel({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.origin,
    required this.meanings,
  });

  factory WordMetadataModel.fromJson(Map<String, dynamic> json) {
    return WordMetadataModel(
      word: json["word"],
      phonetic: json["phonetic"],
      phonetics:
          json["phonetics"] == null
              ? const []
              : List<PhoneticModel>.from(
                json["phonetics"]!.map((x) => PhoneticModel.fromJson(x)),
              ),
      origin: json["origin"],
      meanings:
          json["meanings"] == null
              ? const []
              : List<MeaningModel>.from(
                json["meanings"]!.map((x) => MeaningModel.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "word": word,
    "phonetic": phonetic,
    "phonetics": phonetics.map((x) => x.toJson()).toList(),
    "origin": origin,
    "meanings": meanings.map((x) => x.toJson()).toList(),
  };
}
