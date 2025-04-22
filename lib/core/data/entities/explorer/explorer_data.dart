import 'package:open_words/core/data/entities/folder/folder.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';

class ExplorerData {
  final List<Folder> folders;
  final List<WordGroup> groups;

  ExplorerData({required this.folders, required this.groups});
}
