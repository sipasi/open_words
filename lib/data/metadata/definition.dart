import 'package:json_annotation/json_annotation.dart';

part 'definition.g.dart';

@JsonSerializable(explicitToJson: true)
class Definition {
  final String value;
  final String? example;

  Definition({
    required this.value,
    this.example,
  });

  factory Definition.fromJson(Map<String, dynamic> json) =>
      _$DefinitionFromJson(json);

  Map<String, dynamic> toJson() => _$DefinitionToJson(this);
}
