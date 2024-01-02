import 'package:excel/excel.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/export/formatter/format_options.dart';
import 'package:open_words/service/export/word_group/word_group_formatter.dart';

class ExcelFormatter extends WordGroupFormatter {
  @override
  Future<List<int>> format(List<WordGroup> data, FormatOptions options) {
    final document = Excel.createExcel();

    final style = CellStyle(
      bold: true,
      italic: false,
      textWrapping: TextWrapping.WrapText,
      fontFamily: getFontFamily(FontFamily.Arial),
    );

    const String sheetName = 'words';

    document.rename(document.getDefaultSheet()!, sheetName);

    var sheet = document[sheetName];

    const offset = 3;
    const next = 1;

    int column = 0;

    for (var group in data) {
      final words = group.words;

      for (var index = 0; index < words.length; index++) {
        int row = index;

        setValue(
          sheet: sheet,
          style: style,
          row: row,
          column: column,
          value: words[index].origin,
        );
        setValue(
          sheet: sheet,
          style: style,
          row: row,
          column: column + next,
          value: words[index].translation,
        );
      }

      column += offset;
    }

    final bytes = document.save()!;

    return Future.value(bytes);
  }

  static setValue({
    required Sheet sheet,
    required CellStyle style,
    required int row,
    required int column,
    required String value,
  }) {
    var cell = sheet.cell(CellIndex.indexByColumnRow(
      rowIndex: row,
      columnIndex: column,
    ));

    cell.value = TextCellValue(value);

    cell.cellStyle = style;
  }
}
