import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/services/language/language_info_service.dart';
import 'package:open_words/features/settings/import_export/models/word_group_field.dart';

final class LanguageInfoResolver {
  final LanguageInfoService service;

  LanguageInfoResolver({required this.service});

  LanguageInfo originFrom(Map<String, dynamic> map) {
    return _parse(property: WordGroupField.origin.fromMap(map)) ??
        service.english;
  }

  LanguageInfo translationFrom(Map<String, dynamic> map) {
    return _parse(property: WordGroupField.translation.fromMap(map)) ??
        service.ukrainian;
  }

  LanguageInfo? _parse({required dynamic property}) {
    if (property case String code) {
      return service.getByCode(code);
    }

    if (property case Map<String, dynamic> map) {
      return LanguageInfo.fromMap(map);
    }

    return null;
  }
}
