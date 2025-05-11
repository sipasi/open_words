import 'dart:typed_data';

import 'package:open_words/core/services/file/temporary/temporary_file_service.dart';
import 'package:share_plus/share_plus.dart';

/// A service responsible for sharing files, typically with other apps or users.
sealed class FileShareService {
  Future shareFile({
    String? name,
    required String extension,
    required Uint8List data,
  });
}

final class FileShareServiceImpl extends FileShareService {
  final SharePlus share;
  final TemporaryFileService fileService;

  FileShareServiceImpl({required this.share, required this.fileService});

  @override
  Future shareFile({
    String? name,
    required String extension,
    required Uint8List data,
  }) {
    return fileService.withTemporaryFile(
      name: name,
      extension: extension,
      onCreated: (temporary) async {
        await temporary.writeBytes(data);

        await share.share(
          ShareParams(
            title: 'Share file',
            fileNameOverrides: [temporary.fullPath],
            files: [XFile(temporary.fullPath)],
          ),
        );
      },
    );
  }
}
