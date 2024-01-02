import 'package:open_words/service/export/path_factory/folder_location.dart';

abstract class PathFactory {
  Future<String> local(FolderLocation location);
}
