import 'dart:io';
import 'package:open_words/service/export/save_provider/save_provider.dart';

class LocalSaver extends SaveProvider {
  @override
  Future save(List<int> data, String path) async {
    final file = File(path);

    if (await file.exists() == false) {
      file.create(recursive: true);
    }

    return file.writeAsBytes(data, flush: true);
  }
}
