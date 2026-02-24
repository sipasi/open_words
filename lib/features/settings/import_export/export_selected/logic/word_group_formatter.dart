import 'dart:typed_data';

import 'package:open_words/features/settings/import_export/export_selected/logic/word_group_formatter_options.dart';
import 'package:open_words/features/settings/import_export/models/word_group_export.dart';

abstract class WordGroupFormatter<T extends WordGroupFormatterOptions> {
  const WordGroupFormatter();

  Future<Uint8List> format(List<WordGroupExport> groups, {T options});
}
