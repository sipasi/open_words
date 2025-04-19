import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/language_info.dart';

class LanguageInfoConverter extends TypeConverter<LanguageInfo, String>
    with JsonTypeConverter2<LanguageInfo, String, Map<String, Object?>> {
  const LanguageInfoConverter();

  @override
  Map<String, Object?> toJson(LanguageInfo value) {
    return value.toMap();
  }

  @override
  LanguageInfo fromJson(Map<String, Object?> json) {
    return LanguageInfo.fromMap(json);
  }

  @override
  LanguageInfo fromSql(String fromDb) {
    return LanguageInfo.fromJson(fromDb);
  }

  @override
  String toSql(LanguageInfo value) {
    return value.toJson();
  }
}
