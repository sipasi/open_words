import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

sealed class WebFileService {
  Future download({
    required String? name,
    required String extension,
    required Uint8List bytes,
  });
}

final class WebFileServiceImpl extends WebFileService {
  final SharePlus share;

  WebFileServiceImpl({required this.share});

  @override
  Future download({
    required String? name,
    required String extension,
    required Uint8List bytes,
  }) async {
    String fullName = '$name.$extension';

    final file = XFile.fromData(
      bytes,
      name: fullName,
    );

    return share.share(
      ShareParams(
        title: 'Share file',
        fileNameOverrides: [fullName],
        files: [file],
      ),
    );
  }
}
