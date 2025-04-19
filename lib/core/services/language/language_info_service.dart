import 'dart:collection';

import 'package:open_words/core/data/entities/language_info.dart';

sealed class LanguageInfoService {
  int get count;

  LanguageInfo get english;
  LanguageInfo get ukrainian;

  LanguageInfo get(int index);

  UnmodifiableListView<LanguageInfo> getSupported();

  LanguageInfo getByCode(String code);
}

final class LanguageInfoServiceImpl extends LanguageInfoService {
  static const List<LanguageInfo> _languages = [
    LanguageInfo(code: 'en', name: 'English', native: 'English'),
    LanguageInfo(code: 'uk', name: 'Ukrainian', native: 'Українська'),
    LanguageInfo(code: 'no', name: 'Norwegian', native: 'Norsk'),
    LanguageInfo(code: 'fi', name: 'Finnish', native: 'Suomi, suomen kieli'),
    LanguageInfo(code: 'pl', name: 'Polish', native: 'Polski'),
    LanguageInfo(code: 'it', name: 'Italian', native: 'Italiano'),
    LanguageInfo(code: 'de', name: 'German', native: 'Deutsch'),
    LanguageInfo(
      code: 'fr',
      name: 'French',
      native: 'Français, langue française',
    ),
    LanguageInfo(
      code: 'es',
      name: 'Spanish; Castilian',
      native: 'Español, Castellano',
    ),
  ];

  @override
  LanguageInfo get english => getByCode('en');
  @override
  LanguageInfo get ukrainian => getByCode('uk');

  @override
  int get count => _languages.length;

  @override
  LanguageInfo get(int index) => _languages[index];

  @override
  UnmodifiableListView<LanguageInfo> getSupported() =>
      UnmodifiableListView(_languages);

  @override
  LanguageInfo getByCode(String code) {
    return _languages.firstWhere(
      (element) => element.code == code,
      orElse: () => _languages[0],
    );
  }
}
