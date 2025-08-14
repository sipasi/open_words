import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/collection/linq/map_by_extension.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/generated/assets/assets.gen.dart';
import 'package:open_words/core/services/language/language_info_service.dart';

final class LanguageInfoServiceDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    final languages = List<LanguageInfo>.unmodifiable(await _getLanguages());
    final codes = languages.mapBy(property: (language) => language.code);
    final names = languages.mapBy(property: (language) => language.name);

    container.registerSingleton<LanguageInfoService>(
      LanguageInfoServiceImpl(
        languages: languages,
        codeMap: codes,
        nameMap: names,
      ),
    );
  }

  Future<List<LanguageInfo>> _getLanguages() async {
    final content = await rootBundle.loadString(
      Assets.json.language.languageMetadata,
    );

    final list = json.decode(content) as List;

    return List.generate(
      list.length,
      (index) => LanguageInfo.fromMap(list[index]),
    );
  }
}
