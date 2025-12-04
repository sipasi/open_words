import 'package:flutter/foundation.dart';
import 'package:open_words/core/services/file/temporary/temporary_file_service.dart';
import 'package:open_words/core/services/file/web_file/web_file_service.dart';
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
  final WebFileService webService;

  FileShareServiceImpl({
    required this.share,
    required this.fileService,
    required this.webService,
  });

  @override
  Future shareFile({
    String? name,
    required String extension,
    required Uint8List data,
  }) {
    if (kIsWeb) {
      return webService.download(
        name: name,
        extension: extension,
        bytes: data,
      );
    }

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
