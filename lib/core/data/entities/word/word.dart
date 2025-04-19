import 'package:open_words/core/data/entities/entity.dart';
import 'package:open_words/core/data/entities/id.dart';

class Word extends Entity {
  final Id groupId;

  final String origin;
  final String translation;

  Word({
    required super.id,
    required this.groupId,
    required this.origin,
    required this.translation,
  });
}
