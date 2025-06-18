import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:open_words/features/settings_import_export/export_selected/logic/word_group_formatter.dart';
import 'package:open_words/features/settings_import_export/models/word_group_export.dart';

final class WordGroupFormatterJson extends WordGroupFormatter {
  const WordGroupFormatterJson();

  @override
  Uint8List format(List<WordGroupExport> groups) {
    final jsonList = groups.map((group) => group.toMap()).toList();

    final jsonString = convert.jsonEncode(jsonList);

    return Uint8List.fromList(convert.utf8.encode(jsonString));
  }
}
