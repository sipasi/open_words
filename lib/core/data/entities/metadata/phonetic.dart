import 'package:open_words/core/data/entities/entity.dart';
import 'package:open_words/core/data/entities/id.dart';

class Phonetic extends Entity {
  final Id metadataId;

  final String value;
  final String audio;

  Phonetic({
    required super.id,
    required this.metadataId,
    required this.value,
    required this.audio,
  });
}
