import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_request.dart';

final class AiBridgeEmpty extends AiBridge {
  static final instance = AiBridgeEmpty._();

  const AiBridgeEmpty._() : super(const AiTemplate.empty());

  @override
  Future<bool> isConnected() => Future.value(false);
  @override
  Future<String> ask(AiRequest request) => Future.value('');
  @override
  Future<List<String>> models() => Future.value(const []);
}
