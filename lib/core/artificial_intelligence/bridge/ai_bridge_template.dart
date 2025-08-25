import 'dart:convert';

import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_type.dart';
import 'package:uuid/v4.dart';

class AiTemplate {
  final String id;

  final String uri;
  final String model;
  final AiBridgeType type;
  final String apiKey;

  AiTemplate({
    required this.id,
    required this.uri,
    required this.model,
    required this.type,
    required this.apiKey,
  });
  AiTemplate.uuid({
    required this.uri,
    required this.model,
    required this.type,
    required this.apiKey,
  }) : id = UuidV4().generate();

  const AiTemplate.empty()
    : id = '',
      uri = '',
      model = '',
      type = AiBridgeType.notConfigured,
      apiKey = '';

  AiTemplate copyWith({
    String? id,
    String? uri,
    String? model,
    AiBridgeType? type,
    String? apiKey,
  }) {
    return AiTemplate(
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

  factory AiTemplate.fromMap(Map<String, dynamic> map) {
    return AiTemplate(
      id: map['id'] ?? '',
      uri: map['uri'] ?? '',
      model: map['model'] ?? '',
      type: AiBridgeType.values[map['type'] ?? 0],
      apiKey: map['apiKey'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AiTemplate.fromJson(String source) =>
      AiTemplate.fromMap(json.decode(source));

  @override
  bool operator ==(covariant AiTemplate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uri == uri &&
        other.model == model &&
        other.type == type &&
        other.apiKey == apiKey;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uri.hashCode ^
        model.hashCode ^
        type.hashCode ^
        apiKey.hashCode;
  }
}
