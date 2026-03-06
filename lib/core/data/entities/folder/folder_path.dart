import 'package:open_words/core/data/entities/entity_id.dart';

class FolderPath {
  final EntityId folderId;
  final EntityId parentId;
  final String path;
  final String name;

  FolderPath({
    required this.folderId,
    required this.parentId,
    required this.path,
    required this.name,
  });

  const FolderPath.root()
    : folderId = const EntityId.empty(),
      parentId = const EntityId.empty(),
      name = "Root",
      path = './';
}
