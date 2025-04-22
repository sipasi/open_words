import 'dart:convert' as convert;

import 'package:drift/drift.dart';

class SynonymAntonymConverter extends TypeConverter<List<String>, String>
    with JsonTypeConverter2<List<String>, String, Map<String, Object?>> {
  const SynonymAntonymConverter();

  @override
  List<String> fromSql(String fromDb) {
    return fromJson(convert.json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(List<String> value) {
    return convert.json.encode(toJson(value));
  }

  @override
  List<String> fromJson(Map<String, Object?> json) {
    return List<String>.from(json.values);
  }

  @override
  Map<String, Object?> toJson(List<String> value) {
    return Map.fromIterable(value);
  }
}
