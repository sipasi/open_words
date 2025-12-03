import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/dependency/app_dependency.dart';
import 'package:open_words/core/services/path/app_directory.dart';
import 'package:open_words/core/services/path/app_directory_provider.dart';
import 'package:path_provider/path_provider.dart';

final class DirectoriesDependency extends AppDependency {
  @override
  Future inject(GetIt container) async {
    if (kIsWeb || kIsWasm) {
      container.registerSingleton(AppDirectoryProvider.notSupported());

      return;
    }

    container.registerSingleton(
      AppDirectoryProvider(
        temporary: await _create(
          'Temporary',
          getTemporaryDirectory,
        ),
        support: await _create(
          'App Support',
          getApplicationSupportDirectory,
        ),
        documents: await _create(
          'App Documents',
          getApplicationDocumentsDirectory,
        ),
        cache: await _create(
          'App Cache',
          getApplicationCacheDirectory,
        ),
        downloads: await _createOrNull(
          'Downloads',
          getDownloadsDirectory,
        ),
      ),
    );
  }

  Future<AppDirectory> _create(
    String label,
    Future<Directory> Function() future,
  ) async {
    return AppDirectory.fromDirectory(label, await future());
  }

  Future<AppDirectory?> _createOrNull(
    String label,
    Future<Directory?> Function() future,
  ) async {
    final directory = await future();

    if (directory == null) {
      return null;
    }

    return AppDirectory.fromDirectory(label, directory);
  }
}
