import 'package:open_words/core/data/entities/entity.dart';
import 'package:open_words/core/data/entities/entity_id.dart';

class Word extends Entity {
  final EntityId groupId;

  final String origin;
  final String translation;

  Word({
    required super.id,
    required this.groupId,
    required this.origin,
    required this.translation,
  });
}
