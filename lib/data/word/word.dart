import 'package:json_annotation/json_annotation.dart';

part 'word.g.dart';

@JsonSerializable(explicitToJson: true)
class Word {
  final String origin;
  final String translation;

  const Word({
    required this.origin,
    required this.translation,
  });

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);

  Word copyWith({
    String? origin,
    String? translation,
  }) {
    return Word(
      origin: origin ?? this.origin,
      translation: translation ?? this.translation,
    );
  }
}
