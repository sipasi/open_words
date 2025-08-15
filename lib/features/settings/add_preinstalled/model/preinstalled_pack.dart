import 'dart:convert';

import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/features/settings/add_preinstalled/model/language_info_resolver.dart';
import 'package:open_words/features/settings/add_preinstalled/model/preinstalled_dictionary.dart';

class PreinstalledPack {
  final String name;
  final String description;

  final LanguageInfo origin;
  final LanguageInfo translation;

  final List<PreinstalledDictionary> dictionaries;

  PreinstalledPack({
    required this.name,
    required this.description,
    required this.origin,
    required this.translation,
    required this.dictionaries,
  });

  factory PreinstalledPack.fromMap({
    required LanguageInfoResolver resolver,
    required Map<String, dynamic> map,
  }) {
    return PreinstalledPack(
      name: map['name'] as String,
      description: map['description'] as String,
      origin: resolver.get(
        property: () => map['origin'],
        or: (service) => service.english,
      ),
      translation: resolver.get(
        property: () => map['translation'],
        or: (service) => service.ukrainian,
      ),
      dictionaries: List<PreinstalledDictionary>.from(
        (map['dictionaries'] as List<dynamic>).map(
          (x) => PreinstalledDictionary.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory PreinstalledPack.fromJson({
    required LanguageInfoResolver languageResolver,
    required String source,
  }) => PreinstalledPack.fromMap(
    resolver: languageResolver,
    map: json.decode(source) as Map<String, dynamic>,
  );
}
