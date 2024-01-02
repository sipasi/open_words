import 'package:flutter/material.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/export/word_group/pdf/pdf_utils.dart';
import 'package:pdf/widgets.dart' as pw;

class WordGroupTable extends pw.StatelessWidget {
  final WordGroup group;
  final ColorScheme? scheme;

  WordGroupTable({required this.group, required this.scheme});

  @override
  pw.Widget build(pw.Context context) {
    final origin = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 14,
      color: PdfUtils.toPdfColorOrNull(scheme?.primary),
    );
    final translation = pw.TextStyle(
      fontSize: 14,
      color: PdfUtils.toPdfColorOrNull(scheme?.secondary),
    );

    return pw.Table(
      columnWidths: {
        0: const pw.FlexColumnWidth(),
        1: const pw.FlexColumnWidth(),
      },
      children: List.generate(
        group.words.length,
        (index) => row(group.words[index], origin, translation),
      ),
    );
  }

  static pw.TableRow row(Word word, pw.TextStyle origin, pw.TextStyle translation) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: pw.Text(word.origin, style: origin),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: pw.Text(word.translation, style: translation),
        ),
      ],
    );
  }
}
