import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_empty.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_type.dart';
import 'package:open_words/core/artificial_intelligence/bridge/lan/ai_lan_bridge.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AiBridgeProvider {
  Future<bool> get isConnected;

  AiBridgeTemplate getInfo();

  Future set(AiBridgeTemplate bridge);
  AiBridge get();
}

final class AiBridgeProviderImpl extends AiBridgeProvider {
  static const String _keyJson = "_ai_bridge_info_";

  final SharedPreferences preferences;

  @override
  Future<bool> get isConnected => get().isConnected();

  AiBridgeProviderImpl({required this.preferences});

  @override
  AiBridgeTemplate getInfo() {
    final text = preferences.getString(_keyJson);

    return text == null
        ? AiBridgeTemplate.empty()
        : AiBridgeTemplate.fromJson(text);
  }

  @override
  Future set(AiBridgeTemplate bridge) async {
    await preferences.setString(_keyJson, bridge.toJson());
  }

  @override
  AiBridge get() {
    final info = getInfo();

    return switch (info.type) {
      AiBridgeType.lan => AiLanBridge(
        tamplateId: info.id,
        uri: Uri.parse(info.uri),
        model: info.model,
      ),
      AiBridgeType.local => AiLanBridge(
        tamplateId: info.id,
        uri: Uri.parse(info.uri),
        model: info.model,
      ),
      AiBridgeType.remote => AiLanBridge(
        tamplateId: info.id,
        uri: Uri.parse(info.uri),
        model: info.model,
      ),
      _ => AiBridgeEmpty.instance,
    };
  }
}
