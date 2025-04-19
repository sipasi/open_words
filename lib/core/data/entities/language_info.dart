import 'dart:convert';

class LanguageInfo {
  final String code;
  final String name;
  final String native;

  const LanguageInfo({
    required this.code,
    required this.name,
    required this.native,
  });
  const LanguageInfo.empty() : code = '', name = '', native = '';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LanguageInfo &&
        other.code == code &&
        other.name == name &&
        other.native == native;
  }

  @override
  int get hashCode => code.hashCode ^ name.hashCode ^ native.hashCode;

  Map<String, dynamic> toMap() {
    return {'code': code, 'name': name, 'native': native};
  }

  factory LanguageInfo.fromMap(Map<String, dynamic> map) {
    return LanguageInfo(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      native: map['native'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageInfo.fromJson(String source) =>
      LanguageInfo.fromMap(json.decode(source));
}
