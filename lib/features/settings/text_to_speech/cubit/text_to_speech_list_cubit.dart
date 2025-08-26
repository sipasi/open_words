import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/services/language/language_info_service.dart';
import 'package:open_words/core/services/text_to_speech/text_to_speech_service.dart';
import 'package:open_words/core/services/text_to_speech/text_to_speech_voice.dart';
import 'package:open_words/core/services/text_to_speech/text_to_speech_voice_storage.dart';

part 'text_to_speech_list_state.dart';

class TextToSpeechListCubit extends Cubit<TextToSpeechListState> {
  final TextToSpeechService textToSpeech;
  final TextToSpeechVoiceStorage voiceStorage;
  final LanguageInfoService languageInfoService;
  final WordGroupRepository groupRepository;

  TextToSpeechListCubit({
    required this.textToSpeech,
    required this.voiceStorage,
    required this.languageInfoService,
    required this.groupRepository,
  }) : super(TextToSpeechListState.initial());

  Future init() async {
    final uniqueLanguages = await groupRepository.allUniqueLanguages();
    final selectedVoice = <LanguageInfo, TextToSpeechVoice>{};

    for (var unique in uniqueLanguages) {
      bool supported = textToSpeech.languages.contains(unique);

      if (supported == false) {
        selectedVoice[unique] = const TextToSpeechVoice.notSupported();

        continue;
      }

      final voice = voiceStorage.getByLanguage(unique);

      if (voice != null) {
        selectedVoice[unique] = voice;
      }
    }

    emit(
      state.copyWith(languages: uniqueLanguages, selectedVoice: selectedVoice),
    );
  }

  Future rememberVoice(LanguageInfo language, TextToSpeechVoice voice) async {
    await voiceStorage.remember(language, voice);

    final selectedVoice = Map<LanguageInfo, TextToSpeechVoice>.from(
      state.selectedVoice,
    );

    selectedVoice[language] = voice;

    emit(state.copyWith(selectedVoice: selectedVoice));

    if (state.exampleText.isNotEmpty) {
      textToSpeech.stopAndSpeek(
        text: state.exampleText,
        language: language,
        voice: voice,
      );
    }
  }

  void setExampleText(String value) {
    emit(state.copyWith(exampleText: value));
  }
}
