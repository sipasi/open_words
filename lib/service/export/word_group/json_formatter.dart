import 'dart:convert';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/export/formatter/format_options.dart';
import 'package:open_words/service/export/word_group/word_group_formatter.dart';
import 'package:open_words/service/json/import_export_json.dart';

class JsonFormatter extends WordGroupFormatter {
  @override
  Future<List<int>> format(List<WordGroup> data, FormatOptions options) {
    String result = ImportExportJson.group.to(data);

    final bytes = utf8.encode(result);

    return Future.value(bytes);
  }
}
