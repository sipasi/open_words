import 'package:http/http.dart' as http;
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_type.dart';

abstract class AiBridge {
  final String tamplateId;

  final Uri uri;
  final String model;
  final AiBridgeType type;
  final String apiKey;

  const AiBridge({
    required this.tamplateId,
    required this.uri,
    required this.model,
    required this.type,
    required this.apiKey,
  });

  Future<bool> isConnected();

  Future<http.Response?> send({
    required String message,
    required double temperature,
    required int maxTokens,
  });
}
