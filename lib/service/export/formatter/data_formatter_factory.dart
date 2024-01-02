import 'package:open_words/service/export/formatter/data_formatter.dart';
import 'package:open_words/service/export/formatter/export_format.dart';

abstract class DataFormatterFactory<T> {
  DataFormatter<T> create(ExportFormat format);
}
