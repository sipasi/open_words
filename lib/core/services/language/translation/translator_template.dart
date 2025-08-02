import 'dart:convert';

import 'package:open_words/core/services/language/translation/translator_brand.dart';
import 'package:open_words/core/services/language/translation/translator_launch_type.dart';

final class TranslatorTemplate {
  final TranslatorBrand brand;
  final TranslatorLaunchType launch;

  const TranslatorTemplate({required this.brand, required this.launch});
  const TranslatorTemplate.google()
    : brand = TranslatorBrand.google,
      launch = TranslatorLaunchType.translatorApp;

  TranslatorTemplate copyWith({
    TranslatorBrand? brand,
    TranslatorLaunchType? launch,
  }) {
    return TranslatorTemplate(
      brand: brand ?? this.brand,
      launch: launch ?? this.launch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brand': brand.index,
      'launch': launch.index,
    };
  }

  factory TranslatorTemplate.fromMap(Map<String, dynamic> map) {
    return TranslatorTemplate(
      brand: TranslatorBrand.values[map['brand'] ?? 0],
      launch: TranslatorLaunchType.values[map['launch'] ?? 0],
    );
  }

  String toJson() => json.encode(toMap());

  factory TranslatorTemplate.fromJson(String source) =>
      TranslatorTemplate.fromMap(json.decode(source));
}
