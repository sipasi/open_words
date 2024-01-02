import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/export/formatter/data_formatter.dart';
import 'package:open_words/service/export/formatter/data_formatter_factory.dart';
import 'package:open_words/service/export/formatter/export_format.dart';
import 'package:open_words/service/export/word_group/excel_formatter.dart';
import 'package:open_words/service/export/word_group/json_formatter.dart';
import 'package:open_words/service/export/word_group/pdf/pdf_formatter.dart';
import 'package:open_words/service/export/word_group/text_formatter.dart';

class WordGroupFormatterFactory extends DataFormatterFactory<List<WordGroup>> {
  @override
  DataFormatter<List<WordGroup>> create(ExportFormat format) => switch (format) {
        ExportFormat.excel => ExcelFormatter(),
        ExportFormat.pdf => PdfFormatter(),
        ExportFormat.json => JsonFormatter(),
        ExportFormat.text => TextFormatter(),
      };
}
