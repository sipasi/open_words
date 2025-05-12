import 'package:open_words/core/data/entities/language_info.dart';

sealed class LanguageInfoService {
  const LanguageInfoService();

  int get count;

  LanguageInfo get english;
  LanguageInfo get ukrainian;

  LanguageInfo get(int index);

  List<LanguageInfo> getSupported();

  LanguageInfo? getByCode(String code);
  LanguageInfo? getByName(String code);

  bool containsCode(String code);
  bool containsName(String name);
}

final class LanguageInfoServiceImpl extends LanguageInfoService {
  final List<LanguageInfo> languages;
  final Map<String, LanguageInfo> codeMap;
  final Map<String, LanguageInfo> nameMap;

  const LanguageInfoServiceImpl({
    required this.languages,
    required this.codeMap,
    required this.nameMap,
  });

  @override
  LanguageInfo get english => getByCode('en')!;
  @override
  LanguageInfo get ukrainian => getByCode('uk')!;

  @override
  int get count => languages.length;

  @override
  LanguageInfo get(int index) => languages[index];

  @override
  List<LanguageInfo> getSupported() => languages;

  @override
  LanguageInfo? getByCode(String code) {
    return codeMap[code];
  }

  @override
  LanguageInfo? getByName(String code) {
    return nameMap[code];
  }

  @override
  bool containsCode(String code) {
    return codeMap.containsKey(code);
  }

  @override
  bool containsName(String name) {
    return nameMap.containsKey(name);
  }
}
