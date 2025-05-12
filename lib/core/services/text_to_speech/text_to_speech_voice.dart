import 'dart:convert';

class TextToSpeechVoice {
  final String name;
  final String locale;
  final String code;
  final String? gender;
  final String? quality;

  TextToSpeechVoice({
    required this.name,
    required this.locale,
    required this.gender,
    required this.quality,
  }) : code = locale.substring(0, 2);

  String description() {
    String text = 'locale: $locale';

    if (gender != null) {
      text += ', gender: $gender';
    }
    if (quality != null) {
      text += ', quality: $quality';
    }

    return text;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TextToSpeechVoice &&
        other.name == name &&
        other.locale == locale &&
        other.code == code &&
        other.gender == gender &&
        other.quality == quality;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        locale.hashCode ^
        code.hashCode ^
        gender.hashCode ^
        quality.hashCode;
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'locale': locale,
      'gender': gender ?? '',
      'quality': quality ?? '',
    };
  }

  factory TextToSpeechVoice.fromMap(Map<String, dynamic> map) {
    return TextToSpeechVoice(
      name: map['name'] ?? '',
      locale: map['locale'] ?? '',
      gender: map['gender'],
      quality: map['quality'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TextToSpeechVoice.fromJson(String source) =>
      TextToSpeechVoice.fromMap(json.decode(source));
}
