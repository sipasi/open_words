import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/services/logger/app_logger.dart';
import 'package:open_words/core/services/text_to_speech/text_to_speech_voice.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class TextToSpeechVoiceStorage {
  TextToSpeechVoice? getByLanguage(LanguageInfo language);
  Future remember(LanguageInfo language, TextToSpeechVoice value);
}

final class TextToSpeechVoiceStorageImpl extends TextToSpeechVoiceStorage {
  static const _keyVoice = 'key_voice_';

  final SharedPreferences preferences;
  final AppLogger logger;

  TextToSpeechVoiceStorageImpl({
    required this.preferences,
    required this.logger,
  });

  @override
  TextToSpeechVoice? getByLanguage(LanguageInfo language) {
    final key = generateKey(language);

    final remembered = preferences.getString(key);

    if (remembered == null || remembered.isEmpty) {
      return null;
    }

    try {
      return TextToSpeechVoice.fromJson(remembered);
    } catch (e) {
      logger.f(
        '[TextToSpeechVoiceStorageImpl] - key existed but cant parce',
        error: e,
      );
    }

    return null;
  }

  @override
  Future remember(LanguageInfo language, TextToSpeechVoice value) async {
    final key = generateKey(language);

    await preferences.setString(key, value.toJson());
  }

  String generateKey(LanguageInfo language) => _keyVoice + language.code;
}
