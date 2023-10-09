import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_words/data/language_info.dart';

class TextToSpeechService {
  final FlutterTts _tts = FlutterTts();

  Future stopAndSpeek(String text, LanguageInfo language) {
    return Future.wait([stop(), speak(text, language)]);
  }

  Future stop() {
    return _tts.stop();
  }

  Future speak(String text, LanguageInfo language) {
    _tts.setLanguage(language.code);

    return _tts.speak(text);
  }
}
