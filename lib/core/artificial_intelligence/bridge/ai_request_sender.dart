import 'dart:convert' as convert;
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_endpoint.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_request.dart';
import 'package:open_words/core/services/logger/app_logger.dart';

sealed class AiRequestSender {
  static final _encoding = convert.Encoding.getByName('utf8');

  static Future<http.Response?> post({
    required AiTemplate template,
    required AiRequest request,
    required AiEndpoint endpoint,
  }) async {
    http.Response? response;

    final url = Uri.parse(
      endpoint.applyTo(template.uri),
    );

    try {
      response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: convert.jsonEncode({
          'model': template.model,
          'prompt': request.message,
          'temperature': request.temperature,
          'max_tokens': request.maxTokens,
        }),
        encoding: _encoding,
      );

      _log(response: response);
    } catch (e) {
      _log(error: e);
    }

    return response;
  }

  static Future<http.Response?> get({
    required String uri,
    required AiEndpoint endpoint,
  }) async {
    http.Response? response;

    final url = Uri.parse(
      endpoint.applyTo(uri),
    );

    try {
      response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      _log(response: response);
    } catch (e) {
      _log(error: e);
    }

    return response;
  }

  static void _log({http.Response? response, Object? error}) {
    if (GetIt.I.isRegistered<AppLogger>() == false) {
      return;
    }

    final logger = GetIt.I.get<AppLogger>();

    if (response == null || error != null) {
      logger.e("[$AiRequestSender] Throwed Exeption\nerror:$error");

      return;
    }

    if (response.statusCode == 200) {
      logger.i(
        "[$AiRequestSender] Request success\nresponse body:${response.body}",
      );
    } else {
      logger.e(
        "[$AiRequestSender] Request failed with status: ${response.statusCode}\nresponse body:${response.body}",
      );
    }
  }
}
