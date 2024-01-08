import 'dart:convert';

import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/export/formatter/format_options.dart';
import 'package:open_words/service/export/word_group/word_group_formatter.dart';

class TextFormatter extends WordGroupFormatter {
  @override
  Future<List<int>> format(List<WordGroup> data, FormatOptions options) {
    final buffer = StringBuffer();

    for (var element in data) {
      writeWordGroup(buffer, element);
    }

    final text = buffer.toString();

    final bytes = utf8.encode(text);

    return Future.value(bytes);
  }

  void writeWordGroup(StringBuffer buffer, WordGroup data) {
    buffer.write('name: ');
    buffer.write(data.name);

    buffer.writeln();

    buffer.write('origin: ');
    buffer.write(data.origin);

    buffer.writeln();

    buffer.write('translation: ');
    buffer.write(data.translation);

    buffer.writeln();

    buffer.writeln('words:');

    for (var entity in data.words) {
      buffer.write(entity.origin);
      buffer.write(' - ');
      buffer.write(entity.translation);

      buffer.writeln();
    }
  }
}
