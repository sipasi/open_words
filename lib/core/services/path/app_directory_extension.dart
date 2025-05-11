import 'package:open_words/core/services/path/app_directory.dart';
import 'package:path/path.dart';

extension AppDirectoryExtension on AppDirectory {
  AppDirectory withSubPath({
    required String label,
    required List<String> parts,
  }) {
    return AppDirectory(label: label, path: joinAllPath(parts));
  }

  String joinPath(String part) {
    return join(path, part);
  }

  String joinAllPath(List<String> parts) {
    return joinAll([path, ...parts]);
  }
}
