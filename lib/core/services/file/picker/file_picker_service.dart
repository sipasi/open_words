import 'dart:io';

import 'package:file_picker/file_picker.dart';

sealed class FilePickerService {
  Future<List<File>> pickFiles({
    required String title,
    bool lockParentWindow = true,
    bool allowMultiple = true,
  });
}

final class FilePickerServiceImpl extends FilePickerService {
  @override
  Future<List<File>> pickFiles({
    required String title,
    bool lockParentWindow = true,
    bool allowMultiple = true,
  }) async {
    final picked = await FilePicker.platform.pickFiles(
      dialogTitle: title,
      allowMultiple: allowMultiple,
      lockParentWindow: lockParentWindow,
    );

    if (picked == null || picked.paths.isEmpty) {
      return const [];
    }

    return picked.paths.cast<String>().map((path) => File(path)).toList();
  }
}
