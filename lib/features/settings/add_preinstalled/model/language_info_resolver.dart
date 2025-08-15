import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/services/language/language_info_service.dart';

final class LanguageInfoResolver {
  final LanguageInfoService _service;

  LanguageInfoResolver({
    required LanguageInfoService service,
  }) : _service = service;

  LanguageInfo get({
    required dynamic Function() property,
    required LanguageInfo Function(LanguageInfoService service) or,
  }) {
    final value = property();

    final result = switch (value) {
      String code => _service.getByCode(code),
      Map<String, dynamic> map => LanguageInfo.fromMap(map),
      _ => null,
    };

    return result ?? or(_service);
  }
}
