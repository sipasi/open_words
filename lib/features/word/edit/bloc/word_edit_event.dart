part of 'word_edit_bloc.dart';

sealed class WordEditEvent {}

final class WordEditStarted extends WordEditEvent {
  final String translation;
  final WordMetadata metadata;

  WordEditStarted({required this.translation, required this.metadata});
}

final class WordEditSaveRequested extends WordEditEvent {
  WordEditSaveRequested();
}

final class WordEditTranslationChanged extends WordEditEvent {
  final String value;

  WordEditTranslationChanged(this.value);
}

final class WordEditEtymologyChanged extends WordEditEvent {
  final String value;

  WordEditEtymologyChanged(this.value);
}

final class WordEditPhoneticCreateRequested extends WordEditEvent {
  final String value;
  final String audio;

  WordEditPhoneticCreateRequested({required this.value, required this.audio});
}

final class WordEditPhoneticUpdateRequested extends WordEditEvent {
  final Phonetic toUpdate;
  final String value;
  final String audio;

  WordEditPhoneticUpdateRequested({
    required this.toUpdate,
    required this.value,
    required this.audio,
  });
}

final class WordEditPhoneticDeleteRequested extends WordEditEvent {
  final Phonetic value;

  WordEditPhoneticDeleteRequested(this.value);
}

final class WordEditMeaningCreateRequested extends WordEditEvent {
  final String partOfSpeech;
  final List<Definition> definitions;
  final List<String> synonyms;
  final List<String> antonyms;

  WordEditMeaningCreateRequested({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });
}

final class WordEditMeaningUpdateRequested extends WordEditEvent {
  final Meaning toUpdate;

  final String partOfSpeech;
  final List<Definition> definitions;
  final List<String> synonyms;
  final List<String> antonyms;

  WordEditMeaningUpdateRequested({
    required this.toUpdate,
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });
}

final class WordEditMeaningDeleteRequested extends WordEditEvent {
  final Meaning value;

  WordEditMeaningDeleteRequested(this.value);
}
