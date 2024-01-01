import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:open_words/service/export/data_formatter.dart';
import 'package:open_words/service/export/export_format.dart';
import 'package:open_words/service/export/format_options.dart';
import 'package:share_plus/share_plus.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path_dart;

abstract class ShareFile {
  static final _logger = Logger();

  static Future<ShareResult> share({
    required BuildContext context,
    required String path,
  }) async {
    ShareResult result;

    final files = [XFile(path)];

    try {
      result = await Share.shareXFiles(
        files,
        sharePositionOrigin: _getSharePositionOrigin(context),
      );
    } catch (error) {
      _logger.e(error);

      result = const ShareResult('Error', ShareResultStatus.dismissed);
    }

    if (Platform.isWindows == false) {
      await delete(files);
    }

    return result;
  }

  static Future<ShareResult> shareData<T>({
    required BuildContext context,
    required String name,
    required T data,
    required DataFormatter<T> formatter,
    required ExportFormat format,
    required FormatOptions options,
  }) async {
    final temp = await path_provider.getTemporaryDirectory();

    final path = path_dart.join(temp.path, '$name.${format.extension}');

    final file = File(path);

    final bytes = await formatter.format(data, options);

    await file.writeAsBytes(bytes, flush: true);

    return share(context: context, path: path);
  }

  static Future delete(List<XFile> files) async {
    for (var element in files) {
      final path = element.path;

      final file = File(path);

      final exists = await file.exists();

      if (exists) {
        await file.delete();

        _logger.i('The file [${element.name}] have been deleted successful. path [$path]');

        return;
      }

      _logger.e('The file [${element.name}] have not been deleted. path [$path]');
    }
  }

  // for ipad
  static Rect? _getSharePositionOrigin(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;

    if (box == null) {
      return null;
    }

    return box.localToGlobal(Offset.zero) & box.size;
  }
}
