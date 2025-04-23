import 'package:open_words/core/data/entities/id.dart';

abstract class Entity {
  final Id id;

  const Entity({required this.id});
}
