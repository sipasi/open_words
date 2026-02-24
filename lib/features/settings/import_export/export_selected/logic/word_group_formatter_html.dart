import 'dart:convert' as convert;

import 'package:flutter/services.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/html/html_export.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/html/html_word_group_formatter_options.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/word_group_formatter.dart';
import 'package:open_words/features/settings/import_export/models/word_group_export.dart';

final class WordGroupFormatterHtml
    extends WordGroupFormatter<HtmlWordGroupFormatterOptions> {
  const WordGroupFormatterHtml();

  @override
  Future<Uint8List> format(
    List<WordGroupExport> groups, {
    HtmlWordGroupFormatterOptions options =
        const HtmlWordGroupFormatterOptions.empty(),
  }) async {
    final html = await HtmlExport.create(groups, options);

    return Uint8List.fromList(
      convert.utf8.encode(html),
    );
  }
}
