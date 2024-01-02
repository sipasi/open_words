import 'dart:convert';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/export/formatter/format_options.dart';
import 'package:open_words/service/export/word_group/word_group_formatter.dart';

class JsonFormatter extends WordGroupFormatter {
  @override
  Future<List<int>> format(List<WordGroup> data, FormatOptions options) {
    String result = json.encode(data);

    return Future.value(result.codeUnits);
  }
}
