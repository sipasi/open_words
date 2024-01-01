import 'package:json_annotation/json_annotation.dart';

part 'word.g.dart';

@JsonSerializable(explicitToJson: true)
class Word {
  final String origin;
  final String translation;

  final int index;

  const Word({
    required this.origin,
    required this.translation,
    required this.index,
  });

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);

  Word copyWith({
    String? origin,
    String? translation,
    int? index,
  }) {
    return Word(
      origin: origin ?? this.origin,
      translation: translation ?? this.translation,
      index: index ?? this.index,
    );
  }
}
