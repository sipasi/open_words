import 'package:open_words/core/data/entities/entity.dart';
import 'package:open_words/core/data/entities/id.dart';

class Definition extends Entity {
  final Id meaningId;

  final String value;
  final String example;

  const Definition({
    required super.id,
    required this.meaningId,
    required this.value,
    required this.example,
  });

  Definition copyWith({Id? id, Id? meaningId, String? value, String? example}) {
    return Definition(
      id: id ?? this.id,
      meaningId: meaningId ?? this.meaningId,
      value: value ?? this.value,
      example: example ?? this.example,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Definition &&
        other.id == id &&
        other.meaningId == meaningId &&
        other.value == value &&
        other.example == example;
  }

  @override
  int get hashCode =>
      id.hashCode ^ meaningId.hashCode ^ value.hashCode ^ example.hashCode;
}
