import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:open_words/core/services/path/app_directory_provider.dart';

import 'package:path/path.dart' as path;

sealed class AppLogger {
  /// Log a message at level [Level.debug].
  void d(dynamic message, {Object? error});

  /// Log a message at level [Level.info].
  void i(dynamic message, {Object? error});

  /// Log a message at level [Level.warning].
  void w(dynamic message, {Object? error});

  /// Log a message at level [Level.error].
  void e(dynamic message, {Object? error});

  /// Log a message at level [Level.fatal].
  void f(dynamic message, {Object? error});
}

final class AppLoggerImpl extends AppLogger {
  final Logger _logger;

  AppLoggerImpl._(this._logger);

  static Future<AppLoggerImpl> create(AppDirectoryProvider directories) async {
    late final LogOutput output;
    late final LogFilter filter;
    late final Level level;

    if (kDebugMode || kIsWeb || kIsWasm) {
      output = ConsoleOutput();
      filter = DevelopmentFilter();
      level = Level.all;
    } else {
      final file = File(
        path.join(
          directories.documents.path,
          'OpenWordsLogs',
          '${DateTime.now().toIso8601String()}.txt',
        ),
      );

      output = FileOutput(file: await file.create(recursive: true));
      filter = ProductionFilter();
      level = Level.error;
    }

    return AppLoggerImpl._(
      Logger(filter: filter, output: output, level: level),
    );
  }

  @override
  void d(message, {Object? error}) {
    _logger.d(message, error: error);
  }

  @override
  void e(message, {Object? error}) {
    _logger.e(message, error: error);
  }

  @override
  void f(message, {Object? error}) {
    _logger.f(message, error: error);
  }

  @override
  void i(message, {Object? error}) {
    _logger.i(message, error: error);
  }

  @override
  void w(message, {Object? error}) {
    _logger.w(message, error: error);
  }
}
