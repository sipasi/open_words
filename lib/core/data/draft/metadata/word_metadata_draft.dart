import 'package:open_words/core/data/draft/metadata/meaning_draft.dart';
import 'package:open_words/core/data/draft/metadata/phonetic_draft.dart';
import 'package:open_words/core/data/entities/metadata/word_metadata.dart';

class WordMetadataDraft {
  final String word;

  final String etymology;

  final List<PhoneticDraft> phonetics;

  final List<MeaningDraft> meanings;

  WordMetadataDraft({
    required this.word,
    required this.etymology,
    required this.phonetics,
    required this.meanings,
  });

  WordMetadataDraft.fromMetadata(WordMetadata metadata)
    : word = metadata.word,
      etymology = metadata.etymology,
      phonetics = metadata.phonetics.map(PhoneticDraft.fromPhonetic).toList(),
      meanings = metadata.meanings.map(MeaningDraft.fromMeaning).toList();
}
