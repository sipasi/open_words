import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/export/formatter/data_formatter.dart';
import 'package:open_words/service/export/formatter/format_options.dart';
import 'package:open_words/service/export/formatter/pdf_format_options.dart';
import 'package:open_words/service/export/word_group/word_group_formatter.dart';
import 'package:open_words/theme/color/color_seed.dart';

import 'word_group_document.dart';

class PdfFormatter extends WordGroupFormatter {
  static final _default = PdfFormatOptions(
    print: false,
    scheme: ColorScheme.fromSeed(seedColor: ColorSeed.blue.color, brightness: Brightness.dark),
  );

  @override
  Future<Bytes> format(List<WordGroup> data, FormatOptions options) async {
    final value = options.trycast<PdfFormatOptions>(_default);

    final document = WordGroupDocument(data: data, print: value.print, scheme: value.scheme);

    return document.create();
  }
}
