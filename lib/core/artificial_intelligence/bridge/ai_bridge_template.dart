import 'dart:convert';

import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_type.dart';
import 'package:uuid/v4.dart';

class AiBridgeTemplate {
  final String id;

  final String uri;
  final String model;
  final AiBridgeType type;
  final String apiKey;

  AiBridgeTemplate({
    required this.id,
    required this.uri,
    required this.model,
    required this.type,
    required this.apiKey,
  });
  AiBridgeTemplate.uuid({
    required this.uri,
    required this.model,
    required this.type,
    required this.apiKey,
  }) : id = UuidV4().generate();

  const AiBridgeTemplate.empty()
    : id = '',
      uri = '',
      model = '',
      type = AiBridgeType.notConfigured,
      apiKey = '';
  AiBridgeTemplate.from(AiBridge bridge)
    : id = bridge.tamplateId,
      uri = bridge.uri.toString(),
      model = bridge.model,
      type = bridge.type,
      apiKey = bridge.apiKey;

  AiBridgeTemplate copyWith({
    String? id,
    String? uri,
    String? model,
    AiBridgeType? type,
    String? apiKey,
  }) {
    return AiBridgeTemplate(
      id: id ?? this.id,
      uri: uri ?? this.uri,
      model: model ?? this.model,
      type: type ?? this.type,
      apiKey: apiKey ?? this.apiKey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uri': uri,
      'model': model,
      'type': type.index,
      'apiKey': apiKey,
    };
  }

  factory AiBridgeTemplate.fromMap(Map<String, dynamic> map) {
    return AiBridgeTemplate(
      id: map['id'] ?? '',
      uri: map['uri'] ?? '',
      model: map['model'] ?? '',
      type: AiBridgeType.values[map['type'] ?? 0],
      apiKey: map['apiKey'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AiBridgeTemplate.fromJson(String source) =>
      AiBridgeTemplate.fromMap(json.decode(source));
}
