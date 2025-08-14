import 'dart:typed_data';

import 'package:open_words/features/settings/import_export/export_selected/logic/word_group_formatter.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/word_group_formatter_json.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/word_group_formatter_text.dart';
import 'package:open_words/features/settings/import_export/export_selected/models/export_extension.dart';
import 'package:open_words/features/settings/import_export/models/word_group_export.dart';

sealed class WordGroupFormatterFactory {
  static WordGroupFormatter get(ExportExtension extension) {
    return switch (extension) {
      ExportExtension.json => WordGroupFormatterJson(),
      ExportExtension.text => WordGroupFormatterText(),
      _ => throw UnimplementedError(extension.name),
    };
  }

  static Uint8List format(
    ExportExtension extension,
    List<WordGroupExport> groups,
  ) {
    final formatter = get(extension);

    return formatter.format(groups);
  }
}
