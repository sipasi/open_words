import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:open_words/features/settings_import_export/export_selected/logic/word_group_formatter.dart';
import 'package:open_words/features/settings_import_export/models/word_export.dart';
import 'package:open_words/features/settings_import_export/models/word_group_export.dart';

final class WordGroupFormatterText extends WordGroupFormatter {
  const WordGroupFormatterText();

  @override
  Uint8List format(List<WordGroupExport> groups) {
    final text = _buildText(groups);

    return Uint8List.fromList(convert.utf8.encode(text));
  }

  String _buildText(List<WordGroupExport> groups) {
    final buffer = StringBuffer();

    bool notFirst = false;

    for (final group in groups) {
      if (notFirst) {
        buffer.writeDivider();
      }

      buffer.writeGroupInfo(group);

      buffer.writeln();

      buffer.writeWords(group.words);

      notFirst = true;
    }

    return buffer.toString();
  }
}

extension _WordGroupWriter on StringBuffer {
  static final _sectionDivider = '-' * 75;

  void writeGroupInfo(WordGroupExport group) {
    writeLnWithDash('name', group.name);
    writeLnWithDash('origin', group.origin.native);
    writeLnWithDash('translation', group.translation.native);
  }

  void writeWords(List<WordExport> words) {
    for (var word in words) {
      writeLnWithDash(word.origin, word.translation);
    }
  }

  void writeDivider() {
    writeln();
    writeln(_sectionDivider);
    writeln();
  }

  void writeLnWithDash(String first, String second) {
    write(first);
    write(' - ');
    writeln(second);
  }
}
