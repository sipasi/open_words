import 'dart:convert' as convert;

import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/collection/linq/sort_by.dart';
import 'package:open_words/core/services/secure_storage/secure_storage.dart';

abstract class AiBridgeTamplateStorage {
  Future add(AiTemplate info);

  Future<List<AiTemplate>> getAll();

  Future remove(String id);

  Future replace({required String id, required AiTemplate value});

  Future clear();
}

final class AiBridgeTamplateStorageImpl extends AiBridgeTamplateStorage {
  static const String _keyJson = "_ai_bridge_tamplates_";

  final SecureStorage secure;

  AiBridgeTamplateStorageImpl({required this.secure});

  @override
  Future add(AiTemplate info) async {
    final all = await getAll();

    await _write([...all, info]);
  }

  @override
  Future<List<AiTemplate>> getAll() async {
    final json = await secure.read(_keyJson);

    final allRaw = json == null
        ? const []
        : convert.json.decode(json) as List<dynamic>;

    final all = allRaw.map((e) => AiTemplate.fromJson(e)).toList();

    all.sortAscBy((item) => item.model);

    return all;
  }

  @override
  Future replace({required String id, required AiTemplate value}) async {
    final all = await getAll();

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

    await _write([...all, updated]);
  }

  @override
  Future remove(String id) async {
    final all = await getAll();

    all.removeWhere((element) => element.id == id);

    await _write(all);
  }

  @override
  Future clear() {
    return _write(const []);
  }

  Future _write(List<AiTemplate> templates) {
    final json = convert.json.encode(templates.map((e) => e.toJson()).toList());

    return secure.write(
      key: _keyJson,
      value: json,
    );
  }
}
