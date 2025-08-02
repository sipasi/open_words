import 'dart:convert' as convert;

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_type.dart';
import 'package:open_words/core/services/logger/app_logger.dart';

class AiLanBridge extends AiBridge {
  static final _encoding = convert.Encoding.getByName('utf8');

  AiLanBridge({
    required super.tamplateId,
    required super.uri,
    required super.model,
    super.apiKey = '',
  }) : super(type: AiBridgeType.lan);

  @override
  Future<bool> isConnected() async {
    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: convert.jsonEncode({'model': model}),
        encoding: _encoding,
      );

      return response.statusCode == 200;
    } catch (e) {
      _log(error: e);

      return false;
    }
  }

  @override
  Future<http.Response?> send({
    required String message,
    required double temperature,
    required int maxTokens,
  }) async {
    http.Response? response;

    try {
      response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: convert.jsonEncode({
          'model': model,
          'prompt': message,
          'temperature': temperature,
          'max_tokens': maxTokens,
        }),
        encoding: _encoding,
      );

      _log(response: response);
    } catch (e) {
      _log(error: e);
    }

    return response;
  }

  void _log({http.Response? response, Object? error}) {
    if (GetIt.I.isRegistered<AppLogger>() == false) {
      return;
    }

    final logger = GetIt.I.get<AppLogger>();

    if (response == null || error != null) {
      logger.e("[$runtimeType] Throwed Exeption\nerror:$error");

      return;
    }

    if (response.statusCode == 200) {
      logger.i(
        "[$runtimeType] Request success\nresponse body:${response.body}",
      );
    } else {
      logger.e(
        "[$runtimeType] Request failed with status: ${response.statusCode}\nresponse body:${response.body}",
      );
    }
  }
}
