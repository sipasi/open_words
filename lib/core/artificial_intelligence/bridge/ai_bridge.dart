import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_request.dart';

abstract class AiBridge {
  final AiTemplate template;

  const AiBridge(this.template);

  Future<List<String>> models();

  Future<bool> isConnected();

  Future<String> ask(AiRequest request);
}
