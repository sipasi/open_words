import 'package:open_words/core/data/entities/id.dart';

class FolderPath {
  final Id folderId;
  final Id parentId;
  final String path;
  final String name;

  FolderPath({
    required this.folderId,
    required this.parentId,
    required this.path,
    required this.name,
  });

  const FolderPath.root()
    : folderId = const Id.empty(),
      parentId = const Id.empty(),
      name = "Root",
      path = './';
}
