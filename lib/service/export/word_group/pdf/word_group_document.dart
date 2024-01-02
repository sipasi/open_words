import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/export/formatter/data_formatter.dart';
import 'package:open_words/service/export/word_group/pdf/pdf_utils.dart';
import 'package:open_words/service/export/word_group/pdf/word_group_table.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class WordGroupDocument {
  final List<WordGroup> data;

  final bool print;
  final ColorScheme scheme;

  WordGroupDocument({required this.data, required this.print, required this.scheme});

  Future<Bytes> create() async {
    final pdf = await _document();

    final pageTheme = _pageTheme(print ? null : scheme);

    for (var group in data) {
      pdf.addPage(_createPage(group, pageTheme, print ? null : scheme));
    }

    return pdf.save();
  }

  static Future<pw.Document> _document() async {
    var theme = pw.ThemeData.withFont(
      base: pw.Font.ttf(await rootBundle.load("assets/font/roboto/Roboto-Regular.ttf")),
      bold: pw.Font.ttf(await rootBundle.load("assets/font/roboto/Roboto-Bold.ttf")),
      italic: pw.Font.ttf(await rootBundle.load("assets/font/roboto/Roboto-Italic.ttf")),
      boldItalic: pw.Font.ttf(await rootBundle.load("assets/font/roboto/Roboto-BoldItalic.ttf")),
    );

    return pw.Document(theme: theme);
  }

  static pw.Widget _header(String text, ColorScheme? scheme) {
    return pw.Header(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Center(
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
            color: PdfUtils.toPdfColorOrNull(scheme?.onSurface),
          ),
        ),
      ),
      decoration: pw.BoxDecoration(
        color: PdfUtils.toPdfColorOrNull(scheme?.surfaceVariant),
      ),
    );
  }

  static pw.PageTheme _pageTheme(ColorScheme? scheme) {
    pw.PageTheme theme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Container(
          color: PdfUtils.toPdfColorOrNull(scheme?.surface),
        ),
      ),
    );

    return theme;
  }

  static pw.MultiPage _createPage(WordGroup group, pw.PageTheme theme, ColorScheme? scheme) {
    return pw.MultiPage(
      pageTheme: theme,
      header: (context) => _header(group.name, scheme),
      build: (context) => [WordGroupTable(group: group, scheme: scheme)],
    );
  }
}
