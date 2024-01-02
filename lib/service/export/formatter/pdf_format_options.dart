import 'package:flutter/material.dart';
import 'package:open_words/service/export/formatter/format_options.dart';

class PdfFormatOptions extends FormatOptions {
  final bool print;
  final ColorScheme scheme;

  const PdfFormatOptions({required this.print, required this.scheme});
}
