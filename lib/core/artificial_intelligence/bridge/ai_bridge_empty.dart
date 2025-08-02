import 'package:http/http.dart' as http;
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_type.dart';

final class AiBridgeEmpty extends AiBridge {
  static final instance = AiBridgeEmpty._();

  AiBridgeEmpty._()
    : super(
        tamplateId: '',
        uri: Uri(),
        model: '',
        type: AiBridgeType.notConfigured,
        apiKey: '',
      );

  @override
  Future<bool> isConnected() => Future.value(false);
  @override
  Future<http.Response?> send({
    required String message,
    required double temperature,
    required int maxTokens,
  }) => Future.value(null);
}
