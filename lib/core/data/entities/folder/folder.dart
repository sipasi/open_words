import 'package:open_words/core/data/entities/entity.dart';
import 'package:open_words/core/data/entities/id.dart';

class Folder extends Entity {
  final Id parentId;

  final String name;

  final DateTime created;

  Folder({
    required super.id,
    required this.parentId,
    required this.name,
    required this.created,
  });

  Folder copyWith({Id? parentId, String? name}) {
    return Folder(
      id: id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      created: created,
    );
  }
}
