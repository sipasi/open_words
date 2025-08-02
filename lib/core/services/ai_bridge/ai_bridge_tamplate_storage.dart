import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/collection/linq/sort_by.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AiBridgeTamplateStorage {
  Future add(AiBridgeTemplate info);

  List<AiBridgeTemplate> getAll();

  Future remove(String id);

  Future replace({required String id, required AiBridgeTemplate value});

  Future clear();
}

final class AiBridgeTamplateStorageImpl extends AiBridgeTamplateStorage {
  static const String _keyJson = "_ai_bridge_tamplates_";

  final SharedPreferences preferences;

  AiBridgeTamplateStorageImpl({required this.preferences});

  @override
  Future add(AiBridgeTemplate info) {
    final all = getAll();

    return preferences.setStringList(
      _keyJson,
      [...all, info].map((e) => e.toJson()).toList(),
    );
  }

  @override
  List<AiBridgeTemplate> getAll() {
    final all = preferences
        .getStringList(_keyJson)
        ?.map(AiBridgeTemplate.fromJson)
        .toList();

    all?.sortAscBy((item) => item.model);

    return all ?? const [];
  }

  @override
  Future replace({required String id, required AiBridgeTemplate value}) async {
    final all = getAll();

    final index = all.indexWhere((element) => element.id == id);

    if (index == -1) {
      return;
    }

    final old = all.removeAt(index);

    final updated = old.copyWith(
      model: value.model,
      type: value.type,
      apiKey: value.apiKey,
      uri: value.uri,
    );

    await preferences.setStringList(
      _keyJson,
      [...all, updated].map((e) => e.toJson()).toList(),
    );
  }

  @override
  Future remove(String id) {
    final all = getAll();

    all.removeWhere((element) => element.id == id);

    return preferences.setStringList(
      _keyJson,
      all.map((e) => e.toJson()).toList(),
    );
  }

  @override
  Future clear() {
    return preferences.setStringList(_keyJson, const []);
  }
}
