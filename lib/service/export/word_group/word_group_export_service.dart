import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/export/export_service.dart';

class WordGroupExportService extends ExportService<List<WordGroup>> {
  WordGroupExportService(super.factory, super.path, super.save);
}
