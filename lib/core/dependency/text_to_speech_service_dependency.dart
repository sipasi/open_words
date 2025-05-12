import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/collection/linq/group_by_extension.dart';
import 'package:open_words/core/collection/linq/sort_by.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/language/language_info_service.dart';
import 'package:open_words/core/services/text_to_speech/text_to_speech_service.dart';
import 'package:open_words/core/services/text_to_speech/text_to_speech_voice.dart';
import 'package:open_words/core/services/text_to_speech/text_to_speech_voice_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class TextToSpeechServiceDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    final tts = FlutterTts();

    container.registerSingleton<TextToSpeechVoiceStorage>(
      TextToSpeechVoiceStorageImpl(
        preferences: await SharedPreferences.getInstance(),
        logger: GetIt.I.get(),
      ),
    );
    container.registerSingleton<TextToSpeechService>(
      TextToSpeechServiceImpl(
        tts: tts,
        languages: await getLanguages(tts, GetIt.I.get()),
        voices: await getVoices(tts, GetIt.I.get()),
        speechVoiceStorage: GetIt.I.get(),
      ),
    );

    return Future.value();
  }

  Future<List<LanguageInfo>> getLanguages(
    FlutterTts tts,
    LanguageInfoService languageInfoService,
  ) async {
    final list = List.from(await tts.getLanguages);
    final ttsCodes = list.map((e) => (e as String).substring(0, 2)).toSet();

    final languages =
        languageInfoService
            .getSupported()
            .where((language) => ttsCodes.contains(language.code))
            .toList();

    return languages;
  }

  Future<Map<String, List<TextToSpeechVoice>>> getVoices(
    FlutterTts tts,
    LanguageInfoService languageInfoService,
  ) async {
    final ttsVoices = List.from(await tts.getVoices);

    final grouped = ttsVoices
        .map(
          (e) => TextToSpeechVoice(
            name: e['name'] as String,
            locale: e['locale'] as String,
            gender: e['gender'] as String?,
            quality: e['quality'] as String?,
          ),
        )
        .groupBy((item) => item.code);

    final voices = <String, List<TextToSpeechVoice>>{};

    for (var language in languageInfoService.getSupported()) {
      final group = grouped[language.code];

      if (group != null) {
        voices[language.code] = group..sortDescBy((item) => item.locale);
      }
    }

    return voices;
  }
}
