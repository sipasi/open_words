import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_empty.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_type.dart';
import 'package:open_words/core/artificial_intelligence/bridge/lm_studio/lm_studio_bridge.dart';
import 'package:open_words/core/services/secure_storage/secure_storage.dart';

abstract class AiBridgeProvider {
  Future<bool> get isConnected;

  Future<AiTemplate> getInfo();

  Future set(AiTemplate bridge);

  Future<AiBridge> get();
}

final class AiBridgeProviderImpl extends AiBridgeProvider {
  static const String _keyJson = "_ai_bridge_info_";

  final SecureStorage secure;

  @override
  Future<bool> get isConnected async => (await get()).isConnected();

  AiBridgeProviderImpl({required this.secure});

  @override
  Future<AiTemplate> getInfo() async {
    final text = await secure.read(_keyJson);

    return text == null ? AiTemplate.empty() : AiTemplate.fromJson(text);
  }

  @override
  Future<AiBridge> get() async {
    final info = await getInfo();

    return switch (info.type) {
      AiBridgeType.lan => LmStudioBridge(info),
      AiBridgeType.local => LmStudioBridge(info),
      AiBridgeType.remote => LmStudioBridge(info),
      _ => AiBridgeEmpty.instance,
    };
  }

  @override
  Future set(AiTemplate bridge) async {
    await secure.write(key: _keyJson, value: bridge.toJson());
  }
}
