part of 'word_edit_bloc.dart';

enum WordEditSaveStatus { none, saving, saved }

class WordEditState {
  final WordEditSaveStatus saveStatus;

  final String translation;
  final String etymology;
  final List<Phonetic> phonetics;
  final List<Meaning> meanings;

  final List<Phonetic> phoneticsRemoved;
  final List<Meaning> meaningsRemoved;

  WordEditState({
    required this.saveStatus,
    required this.translation,
    required this.etymology,
    required this.phonetics,
    required this.phoneticsRemoved,
    required this.meanings,
    required this.meaningsRemoved,
  });

  WordEditState.initial()
    : saveStatus = WordEditSaveStatus.none,
      translation = '',
      etymology = '',
      phonetics = const [],
      phoneticsRemoved = const [],
      meanings = const [],
      meaningsRemoved = const [];

  WordEditState copyWith({
    WordEditSaveStatus? saveStatus,
    String? translation,
    String? etymology,
    List<Phonetic>? phonetics,
    List<Meaning>? meanings,
    List<Phonetic>? phoneticsRemoved,
    List<Meaning>? meaningsRemoved,
  }) {
    return WordEditState(
      saveStatus: saveStatus ?? this.saveStatus,
      translation: translation ?? this.translation,
      etymology: etymology ?? this.etymology,
      phonetics: phonetics ?? this.phonetics,
      meanings: meanings ?? this.meanings,
      phoneticsRemoved: phoneticsRemoved ?? this.phoneticsRemoved,
      meaningsRemoved: meaningsRemoved ?? this.meaningsRemoved,
    );
  }
}
