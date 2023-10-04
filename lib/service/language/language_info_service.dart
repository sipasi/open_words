import 'dart:collection';

import 'package:open_words/data/language_info.dart';

class LanguageInfoService {
  static const List<LanguageInfo> _languages = [
    LanguageInfo(code: 'en', name: 'English', native: 'English'),
    LanguageInfo(code: 'uk', name: 'Ukrainian', native: 'Українська'),
    LanguageInfo(code: 'no', name: 'Norwegian', native: 'Norsk'),
    LanguageInfo(code: 'fi', name: 'Finnish', native: 'Suomi, suomen kieli'),
    LanguageInfo(code: 'pl', name: 'Polish', native: 'Polski'),
    LanguageInfo(code: 'it', name: 'Italian', native: 'Italiano'),
    LanguageInfo(code: 'de', name: 'German', native: 'Deutsch'),
    LanguageInfo(code: 'fr', name: 'French', native: 'Français, langue française'),
    LanguageInfo(code: 'es', name: 'Spanish; Castilian', native: 'Español, Castellano'),
  ];

  int get count => _languages.length;

  LanguageInfo get(int index) => _languages[index];

  UnmodifiableListView<LanguageInfo> getSupported() => UnmodifiableListView(_languages);

  LanguageInfo getByCode(String code) {
    return _languages.firstWhere((element) => element.code == code, orElse: () => _languages[0]);
  }
}
