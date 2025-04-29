import 'package:open_words/core/data/entities/metadata/phonetic.dart';

class PhoneticDraft {
  final String value;
  final String audio;

  PhoneticDraft({required this.value, required this.audio});
  PhoneticDraft.fromPhonetic(Phonetic phonetic)
    : value = phonetic.value,
      audio = phonetic.audio;
}
