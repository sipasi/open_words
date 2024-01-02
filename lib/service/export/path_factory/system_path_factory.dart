import 'dart:io';

import 'package:open_words/service/export/path_factory/folder_location.dart';
import 'package:open_words/service/export/path_factory/path_factory.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

class SystemPathFactory extends PathFactory {
  @override
  Future<String> local(FolderLocation location) {
    return switch (location) {
      FolderLocation.downloads => downloads(),
      FolderLocation.documents => documents(),
    };
  }

  Future<String> downloads() async {
    if (Platform.isAndroid) {
      final ditrectory = Directory('/storage/emulated/0/Download');

      if (await ditrectory.exists() == false) {
        ditrectory.create(recursive: true);
      }

      return ditrectory.path;
    }

    final ditrectory = await path_provider.getDownloadsDirectory();

    return ditrectory!.path;
  }

  Future<String> documents() async {
    if (Platform.isAndroid) {
      final ditrectory = Directory('/storage/emulated/0/Documents');

      if (await ditrectory.exists() == false) {
        ditrectory.create();
      }

      return ditrectory.path;
    }

    final ditrectory = await path_provider.getApplicationDocumentsDirectory();

    return ditrectory.path;
  }
}
