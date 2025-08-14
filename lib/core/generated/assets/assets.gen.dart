// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

class $AssetsJsonGen {
  const $AssetsJsonGen();

  /// Directory path: assets/json/dictionary
  $AssetsJsonDictionaryGen get dictionary => const $AssetsJsonDictionaryGen();

  /// Directory path: assets/json/language
  $AssetsJsonLanguageGen get language => const $AssetsJsonLanguageGen();

  /// Directory path: assets/json
  String get path => 'assets/json';
}

class $AssetsJsonDictionaryGen {
  const $AssetsJsonDictionaryGen();

  /// Directory path: assets/json/dictionary/ukrainian
  $AssetsJsonDictionaryUkrainianGen get ukrainian =>
      const $AssetsJsonDictionaryUkrainianGen();

  /// Directory path: assets/json/dictionary
  String get path => 'assets/json/dictionary';
}

class $AssetsJsonLanguageGen {
  const $AssetsJsonLanguageGen();

  /// File path: assets/json/language/language-metadata.json
  String get languageMetadata => 'assets/json/language/language-metadata.json';

  /// Directory path: assets/json/language
  String get path => 'assets/json/language';

  /// List of all assets
  List<String> get values => [languageMetadata];
}

class $AssetsJsonDictionaryUkrainianGen {
  const $AssetsJsonDictionaryUkrainianGen();

  /// File path: assets/json/dictionary/ukrainian/common.json
  String get common => 'assets/json/dictionary/ukrainian/common.json';

  /// Directory path: assets/json/dictionary/ukrainian
  String get path => 'assets/json/dictionary/ukrainian';

  /// List of all assets
  List<String> get values => [common];
}

class Assets {
  const Assets._();

  static const $AssetsJsonGen json = $AssetsJsonGen();
}
