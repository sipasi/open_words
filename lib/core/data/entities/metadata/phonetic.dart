import 'package:open_words/core/data/entities/entity.dart';
import 'package:open_words/core/data/entities/id.dart';

class Phonetic extends Entity {
  final Id metadataId;

  final String value;
  final String audio;

  const Phonetic({
    required super.id,
    required this.metadataId,
    required this.value,
    required this.audio,
  });

  Phonetic copyWith({Id? id, Id? metadataId, String? value, String? audio}) {
    return Phonetic(
      id: id ?? this.id,
      metadataId: metadataId ?? this.metadataId,
      value: value ?? this.value,
      audio: audio ?? this.audio,
    );
  }
}
