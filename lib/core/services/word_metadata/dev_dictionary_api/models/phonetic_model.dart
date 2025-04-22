class PhoneticModel {
  PhoneticModel({required this.text, required this.audio});

  final String? text;
  final String? audio;

  factory PhoneticModel.fromJson(Map<String, dynamic> json) {
    return PhoneticModel(text: json["text"], audio: json["audio"]);
  }

  Map<String, dynamic> toJson() => {"text": text, "audio": audio};

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneticModel && other.text == text && other.audio == audio;
  }

  @override
  int get hashCode => text.hashCode ^ audio.hashCode;
}
