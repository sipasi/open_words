import 'package:json_annotation/json_annotation.dart';

part 'language_info.g.dart';

@JsonSerializable()
class LanguageInfo {
  final String code;
  final String name;
  final String native;

  const LanguageInfo({
    required this.code,
    required this.name,
    required this.native,
  });

  factory LanguageInfo.fromJson(Map<String, dynamic> json) => _$LanguageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageInfoToJson(this);
}
