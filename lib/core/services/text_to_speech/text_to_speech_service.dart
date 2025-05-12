import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/services/text_to_speech/text_to_speech_voice.dart';
import 'package:open_words/core/services/text_to_speech/text_to_speech_voice_storage.dart';

sealed class TextToSpeechService {
  List<LanguageInfo> get languages;

  Future stopAndSpeek({
    required String text,
    required LanguageInfo language,
    TextToSpeechVoice? voice,
  });

  List<TextToSpeechVoice> voicesByLanguage(LanguageInfo language);
}

class TextToSpeechServiceImpl extends TextToSpeechService {
  final FlutterTts _tts;
  final List<LanguageInfo> _languages;
  final Map<String, List<TextToSpeechVoice>> _voices;

  final TextToSpeechVoiceStorage _speechVoiceStorage;

  String _playingText = '';

  @override
  List<LanguageInfo> get languages => _languages;

  TextToSpeechServiceImpl({
    required FlutterTts tts,
    required List<LanguageInfo> languages,
    required Map<String, List<TextToSpeechVoice>> voices,
    required TextToSpeechVoiceStorage speechVoiceStorage,
  }) : _tts = tts,
       _voices = voices,
       _languages = languages,
       _speechVoiceStorage = speechVoiceStorage {
    _tts.setCompletionHandler(_onCompleted);

    _tts.setCancelHandler(_onCancel);
  }

  @override
  Future stopAndSpeek({
    required String text,
    required LanguageInfo language,
    TextToSpeechVoice? voice,
  }) async {
    if (_playingText.isNotEmpty) {
      final sameText = _playingText == text;

      await stop();

      if (sameText) {
        return;
      }
    }

    _playingText = text;

    await speak(text: text, language: language, voice: voice);
  }

  Future stop() {
    return _tts.stop();
  }

  Future speak({
    required String text,
    required LanguageInfo language,
    required TextToSpeechVoice? voice,
  }) async {
    await _tts.setLanguage(language.code);

    final voiceTemp = voice ?? _speechVoiceStorage.getByLanguage(language);

    if (voiceTemp != null) {
      await _tts.setVoice(voiceTemp.toMap());
    }

    await _tts.speak(text);
  }

  @override
  List<TextToSpeechVoice> voicesByLanguage(LanguageInfo language) {
    return voicesByLanguageCode(language.code);
  }

  List<TextToSpeechVoice> voicesByLanguageCode(String code) {
    return _voices[code] ?? const [];
  }

  void _onCompleted() {
    _playingText = '';
  }

  void _onCancel() {
    _playingText = '';
  }
}
