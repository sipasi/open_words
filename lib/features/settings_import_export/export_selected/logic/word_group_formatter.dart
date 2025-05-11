import 'dart:typed_data';

import 'package:open_words/features/settings_import_export/export_selected/models/word_group_export.dart';

abstract class WordGroupFormatter {
  const WordGroupFormatter();

  Uint8List format(List<WordGroupExport> groups);
}
