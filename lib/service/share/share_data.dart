import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';

import 'json_shared_file_factory.dart';
import 'shared_file_factory.dart';

abstract class ShareData {
  static final _logger = Logger();

  static Future<ShareResult> asJson<T>({
    required BuildContext context,
    required List<T> data,
    required String name,
    required String Function(T) manyNamePolicy,
    bool oneFile = false,
  }) async {
    return share(
      context: context,
      data: data,
      factory: JsonSharedFileFactory(name: name, manyNamePolicy: manyNamePolicy),
      oneFile: oneFile,
    );
  }

  static Future<ShareResult> share<T>({
    required BuildContext context,
    required List<T> data,
    required SharedFileFactory<T> factory,
    bool oneFile = true,
  }) async {
    final files = await _prepare(data, factory, oneFile);

    ShareResult result;

    try {
      result = await Share.shareXFiles(
        files,
        sharePositionOrigin: _getSharePositionOrigin(context),
      );
    } catch (error) {
      _logger.e(error);

      result = const ShareResult('Error', ShareResultStatus.dismissed);
    }

    await delete(files);

    return result;
  }

  static Future<List<XFile>> _prepare<T>(List<T> data, SharedFileFactory<T> factory, bool oneFile) async {
    if (oneFile) {
      return [await factory.one(data)];
    }

    return await factory.many(data);
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
