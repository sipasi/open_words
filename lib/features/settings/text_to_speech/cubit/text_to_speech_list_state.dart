part of 'text_to_speech_list_cubit.dart';

class TextToSpeechListState {
  final List<LanguageInfo> languages;
  final Map<LanguageInfo, TextToSpeechVoice> selectedVoice;

  final String exampleText;

  TextToSpeechListState({
    required this.languages,
    required this.selectedVoice,
    required this.exampleText,
  });
  TextToSpeechListState.initial()
    : languages = const [],
      selectedVoice = const {},
      exampleText = '';

  TextToSpeechListState copyWith({
    List<LanguageInfo>? languages,
    Map<LanguageInfo, TextToSpeechVoice>? selectedVoice,
    String? exampleText,
  }) {
    return TextToSpeechListState(
      languages: languages ?? this.languages,
      selectedVoice: selectedVoice ?? this.selectedVoice,
      exampleText: exampleText ?? this.exampleText,
    );
  }
}
