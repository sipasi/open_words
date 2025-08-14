import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_request.dart';

class AiTranslator {
  static const _noTranslation = "__nothing__";

  final AiBridge _bridge;

  final String _source;
  final String _target;

  AiTranslator({
    required AiBridge bridge,
    required String source,
    required String target,
  }) : _bridge = bridge,
       _source = source,
       _target = target;

  Future<String> translate(String text) async {
    if (await _bridge.isConnected() == false) {
      return '';
    }

    final answer = await _bridge.ask(
      AiRequest(
        message: _translatePrompt(text),
        temperature: .3,
        maxTokens: 100,
      ),
    );

    final trimmed = answer.trim();

    return trimmed == _noTranslation ? '' : trimmed;
  }

  String _translatePrompt(String word) {
    return '''
You are a translation engine.

Translate the word "$word" from $_source to $_target.

Return only the translated word.
Do not include explanations, formatting, or additional text.
Do not say "The correct translation is..." or any similar phrasing.

If a reliable translation does not exist, return: $_noTranslation
''';
  }
}
