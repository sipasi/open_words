part of 'editor_phonetic_cubit.dart';

class EditorPhoneticState {
  final String value;
  final String audio;

  bool get canSubmit => value.isNotEmpty || audio.isNotEmpty;

  bool get canNotSubmit => !canSubmit;

  EditorPhoneticState({required this.value, required this.audio});
  EditorPhoneticState.initial() : value = '', audio = '';

  EditorPhoneticState copyWith({String? value, String? audio}) {
    return EditorPhoneticState(
      value: value ?? this.value,
      audio: audio ?? this.audio,
    );
  }
}
