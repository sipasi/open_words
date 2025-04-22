import 'package:open_words/core/data/draft/metadata/meaning_draft.dart';
import 'package:open_words/core/data/draft/metadata/phonetic_draft.dart';

class WordMetadataDraft {
  final String word;

  final String origin;

  final String phonetic;

  final List<PhoneticDraft> phonetics;

  final List<MeaningDraft> meanings;

  WordMetadataDraft({
    required this.word,
    required this.origin,
    required this.phonetic,
    required this.phonetics,
    required this.meanings,
  });
}
