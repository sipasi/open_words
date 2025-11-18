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
      AiRequest.chatCompletions(
        messages: _translateMessages(text),
        temperature: .3,
        maxTokens: 512,
      ),
    );

    final trimmed = answer.trim();

    return trimmed == _noTranslation ? '' : trimmed;
  }

  List<AiRequestMessage> _translateMessages(String word) {
    return [
      .system(
        'You are a translation engine. '
        'Translate $_source to $_target. '
        'Output only the translated word.'
        'No explanations. No reasoning. '
        'Respect the casing of the input word.'
        'If a reliable translation does not exist, return "$_noTranslation"',
      ),
      .user(word),
    ];
  }
}
