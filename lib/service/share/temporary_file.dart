import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as dart_path;
import 'package:path_provider/path_provider.dart' as path_provider;

class TemporaryFile {
  static Future<File> create({required String name, String? directory}) async {
    final path = await _getPath(name, directory);

    final file = File(path);

    final exists = await file.exists();

    if (exists == false) {
      await file.create(recursive: true);
    }

    return file;
  }

  static Future<String> _getPath(String name, String? directory) async {
    final temporary = await _temporary();

    if (directory == null) {
      return dart_path.join(temporary, name);
    }

    return dart_path.join(temporary, directory, name);
  }

  static Future<String> _temporary() async {
    final directory = await path_provider.getTemporaryDirectory();

    return directory.path;
  }
}
