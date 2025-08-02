import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge.dart';

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

  Future<String?> translate(String text) async {
    if (await _bridge.isConnected() == false) {
      return null;
    }

    final prompt = _translatePromt(text);

    final response = await _bridge.send(
      message: prompt,
      maxTokens: 500,
      temperature: .3,
    );

    if (response == null) {
      return null;
    }

    return _extractTranslation(response);
  }

  String? _extractTranslation(http.Response response) {
    if (response.statusCode != 200) {
      return null;
    }

    final json = convert.jsonDecode(response.body);

    final text = switch (json?["choices"]?[0]?['text']) {
      String value => value.trim(),
      _ => null,
    };

    return text == _noTranslation ? null : text;
  }

  String _translatePromt(String word) {
    return """
Translate the given $_source word to $_target with high accuracy
If no reliable translation exist, return "$_noTranslation"
Return the result strictly in pure text format
Do not include any explanations, comments, or extra text
Word to translate: "$word"
""";
  }
}
