import 'dart:io';

import 'package:open_words/core/services/file/local_save/local_file.dart';
import 'package:open_words/core/services/path/app_directory.dart';
import 'package:open_words/core/services/path/app_directory_provider.dart';

sealed class LocalFileService {
  Future<LocalFile> create({
    required AppDirectory directory,
    required String name,
    required String extension,
  });
  Future<LocalFile> createIn({
    required String name,
    required String extension,
    required AppDirectory Function(AppDirectoryProvider directory) place,
  });
}

final class LocalFileServiceImpl extends LocalFileService {
  final AppDirectoryProvider directoryProvider;

  LocalFileServiceImpl({required this.directoryProvider});

  @override
  Future<LocalFile> create({
    required AppDirectory directory,
    required String name,
    required String extension,
  }) async {
    final file = LocalFile(
      directory: directory,
      name: name,
      extension: extension,
    );

    await _ensureCreated(file.fullPath);

    return file;
  }

  Future<File> _ensureCreated(String path) {
    final file = File(path);

    return file.create(recursive: true);
  }

  @override
  Future<LocalFile> createIn({
    required String name,
    required String extension,
    required AppDirectory Function(AppDirectoryProvider directory) place,
  }) {
    return create(
      directory: place(directoryProvider),
      name: name,
      extension: extension,
    );
  }
}
