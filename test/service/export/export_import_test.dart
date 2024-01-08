// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/service/export/export_service.dart';
import 'package:open_words/service/export/formatter/export_format.dart';
import 'package:open_words/service/export/formatter/format_options.dart';
import 'package:open_words/service/export/path_factory/folder_location.dart';
import 'package:open_words/service/export/path_factory/path_factory.dart';
import 'package:open_words/service/export/save_provider/local_saver.dart';

import 'package:open_words/service/export/word_group/word_group_formatter_factory.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final export = createFactory();

  final data = createData();

  test('export-import to downloads as text', () async {
    await export.exportToDownloads(data, 'WordGroupTest', ExportFormat.text, FormatOptions.empty());
  });
  test('export-import to downloads as json', () async {
    await export.exportToDownloads(data, 'WordGroupTest', ExportFormat.json, FormatOptions.empty());
  });
  test('export-import to downloads as pdf', () async {
    await export.exportToDownloads(data, 'WordGroupTest', ExportFormat.pdf, FormatOptions.empty());
  });
  test('export-import to downloads as excel', () async {
    await export.exportToDownloads(data, 'WordGroupTest', ExportFormat.excel, FormatOptions.empty());
  });
}

ExportService<List<WordGroup>> createFactory() {
  final factory = WordGroupFormatterFactory();
  final path = _TestPathService();

  return ExportService(factory, path, LocalSaver());
}

List<WordGroup> createData() {
  final now = DateTime.now();

  return List.generate(
    2,
    (index) => WordGroup(
      id: 'test_$index',
      created: now,
      modified: now,
      name: 'Test name $index',
      origin: const LanguageInfo(code: 'origin:code', name: 'origin:name', native: 'origin:native'),
      translation: const LanguageInfo(code: 'translation:code', name: 'translation:name', native: 'translation:native'),
      words: List.generate(
        40,
        (index) => const Word(
          origin: 'Eu nulla ullamco et ullamco tempor magna qui.',
          translation: 'Cillum ut duis cupidatat cillum.',
        ),
      ),
    ),
  );
}

class _TestPathService extends PathFactory {
  @override
  Future<String> local(FolderLocation location) async {
    return switch (location) {
      FolderLocation.downloads => 'C:\\Users\\tanks\\Downloads',
      _ => 'null',
    };
  }
}
