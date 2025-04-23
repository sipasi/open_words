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
}
