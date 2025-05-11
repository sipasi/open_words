import 'dart:io';
import 'dart:typed_data';

import 'package:open_words/core/services/path/app_directory.dart';
import 'package:open_words/core/services/path/app_directory_extension.dart';

/// Represents a file located in a specific [AppDirectory].
///
/// Provides basic file operations like writing and deleting.
final class LocalFile {
  /// The directory in which this file resides.
  final AppDirectory directory;

  /// The base name of the file (without extension).
  final String name;

  /// The file extension (e.g., 'json', 'txt').
  final String extension;

  /// The full name of the file, including extension (e.g., 'Groups.json').
  final String fullName;

  /// The absolute path to this file in the file system.
  String get fullPath => directory.joinPath(fullName);

  File get _file => File(fullPath);

  const LocalFile({
    required this.directory,
    required this.name,
    required this.extension,
  }) : fullName = '$name.$extension';

  /// Writes [bytes] to the file.
  ///
  /// Set [flush] to true to ensure the data is written to disk immediately.
  Future writeBytes(Uint8List bytes, {bool flush = true}) {
    return _file.writeAsBytes(bytes, flush: flush);
  }

  Future delete() {
    return _file.delete();
  }
}
