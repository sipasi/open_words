import 'dart:convert' as convert;

import 'package:get_it/get_it.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_endpoint.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_request.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_request_sender.dart';
import 'package:open_words/core/services/logger/app_logger.dart';

class LmStudioBridge extends AiBridge {
  LmStudioBridge(super.tamplate);

  @override
  Future<bool> isConnected() async {
    final response = await AiRequestSender.get(
      uri: template.uri,
      endpoint: AiEndpoint.empty,
    );

    return response != null && response.statusCode == 200;
  }

  @override
  Future<List<String>> models() async {
    final response = await AiRequestSender.get(
      uri: template.uri,
      endpoint: AiEndpoint.models,
    );

    if (response == null || response.statusCode != 200) {
      return const [];
    }

    final decoded = convert.json.decode(response.body);

    return switch (decoded) {
      List<dynamic> list =>
        list.map((element) => element["id"] as String).toList(),
      _ => const [],
    };
  }

  @override
  Future<String> ask(AiRequest request) async {
    final response = await AiRequestSender.post(
      template: template,
      request: request,
      endpoint: AiEndpoint.chat,
    );

    if (response == null || response.statusCode != 200) {
      return '';
    }

    try {
      final decoded = convert.json.decode(response.body);

      final choices = decoded['choices'];
      final content = choices[0]?['message']?['content'];
      final text = (content ?? '') as String;

      return text.trim();
    } catch (e) {
      final logger = GetIt.I.get<AppLogger>();

      logger.e('[LmStudioBridge]: json.decode(response.body) throw', error: e);

      return '';
    }
  }
}
