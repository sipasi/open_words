import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

sealed class FilePickerService {
  Future<List<File>> pickFilesAsNative({
    required String title,
    bool lockParentWindow = true,
    bool allowMultiple = true,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  });
  Future<List<Uint8List>> pickFilesAsBytes({
    required String title,
    bool lockParentWindow = true,
    bool allowMultiple = true,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  });
}

final class FilePickerServiceImpl extends FilePickerService {
  @override
  Future<List<File>> pickFilesAsNative({
    required String title,
    bool lockParentWindow = true,
    bool allowMultiple = true,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) async {
    final picked = await _pickFiles(
      title: title,
      allowMultiple: allowMultiple,
      lockParentWindow: lockParentWindow,
      type: type,
      allowedExtensions: allowedExtensions,
    );

    if (picked.paths.isEmpty) {
      return const [];
    }

    return picked.paths.cast<String>().map((path) => File(path)).toList();
  }

  @override
  Future<List<Uint8List>> pickFilesAsBytes({
    required String title,
    bool lockParentWindow = true,
    bool allowMultiple = true,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) async {
    final picked = await _pickFiles(
      title: title,
      allowMultiple: allowMultiple,
      lockParentWindow: lockParentWindow,
      type: type,
      allowedExtensions: allowedExtensions,
    );

    if (picked.xFiles.isEmpty) {
      return const [];
    }

    final byteList = await picked.xFiles.map((file) => file.readAsBytes()).wait;

    return byteList;
  }

  Future<FilePickerResult> _pickFiles({
    required String title,
    bool lockParentWindow = true,
    bool allowMultiple = true,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) async {
    final picked = await FilePicker.platform.pickFiles(
      dialogTitle: title,
      allowMultiple: allowMultiple,
      lockParentWindow: lockParentWindow,
      type: type,
      allowedExtensions: allowedExtensions,
    );

    return picked ?? FilePickerResult(const []);
  }
}
