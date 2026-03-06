import 'package:open_words/core/data/entities/entity_id.dart';

abstract class Entity {
  final EntityId id;

  const Entity({required this.id});
}
