import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/services/language/language_info_service.dart';
import 'package:open_words/core/services/logger/app_logger.dart';

final class LanguageInfoSqlMapper {
  final AppLogger logger;
  final LanguageInfoService languages;

  const LanguageInfoSqlMapper({required this.logger, required this.languages});

  LanguageInfo originFrom(QueryRow row) => _readCode(
    row,
    property: 'origin_code',
    ifNull: languages.english,
  );

  LanguageInfo originOrTranslationFrom(QueryRow row) {
    bool isOrigin = row.readNullable<String>('origin_code') != null;

    return isOrigin ? originFrom(row) : translationFrom(row);
  }

  LanguageInfo translationFrom(QueryRow row) => _readCode(
    row,
    property: 'translation_code',
    ifNull: languages.ukrainian,
  );

  LanguageInfo _readCode(
    QueryRow row, {
    required String property,
    required LanguageInfo ifNull,
  }) {
    final languages = GetIt.I.get<LanguageInfoService>();

    final code = row.read<String>(property);

    final language = languages.getByCode(code);

    if (language == null) {
      logger.f(
        '[LanguageInfoSqlMapper] user request [$code] but service does not contain it',
      );
    }

    return language ?? ifNull;
  }
}
