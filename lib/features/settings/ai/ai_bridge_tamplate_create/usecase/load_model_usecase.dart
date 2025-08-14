import 'dart:convert' as convert;

import 'package:open_words/core/artificial_intelligence/bridge/ai_endpoint.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_request_sender.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/models/ai_bridge_template_model_option.dart';

sealed class LoadModelUsecase {
  static Future<List<AiBridgeTemplateModelOption>> invoke(String url) async {
    final response = await AiRequestSender.get(
      uri: url,
      endpoint: AiEndpoint.models,
    );

    final data = response == null
        ? const []
        : convert.json.decode(response.body)['data'] as List<dynamic>;

    return List.generate(
      data.length,
      (index) => AiBridgeTemplateModelOption(
        id: index,
        name: data[index]['id'].toString(),
      ),
    );
  }
}
