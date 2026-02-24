import 'package:flutter/services.dart';
import 'package:open_words/core/generated/assets/assets.gen.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/html/html_buffer.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/html/html_word_group_formatter_options.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/html/html_writer.dart';
import 'package:open_words/features/settings/import_export/models/word_group_export.dart';

sealed class HtmlExport {
  static Future<String> create(
    List<WordGroupExport> groups,
    HtmlWordGroupFormatterOptions options,
  ) async {
    final assets = await _AssetFiles.load();

    final buffer = HtmlBuffer();
    final writer = HtmlWriter(buffer);

    writer
      ..writeStyles(assets)
      ..writeRoot()
      ..writeJsonScript(options, groups)
      ..writeScripts(assets);

    return buffer.build();
  }
}

extension _AssetWriterExtension on HtmlWriter {
  void writeScripts(_AssetFiles assets) {
    return _write(
      tag: 'script',
      assets: assets.scripts,
    );
  }

  void writeStyles(_AssetFiles assets) {
    return _write(
      tag: 'style',
      assets: assets.styles,
    );
  }

  void _write({
    required String tag,
    required List<_AssetEntry> assets,
  }) {
    for (var asset in assets) {
      this.tag(
        tag: tag,
        attributes: (writer) => writer.add('id', '$tag-${asset.name}'),
        child: (writer) => writer.textLine(asset.content),
      );
    }
  }
}

extension _AppTemplate on HtmlWriter {
  void writeRoot() => tag(
    tag: 'div',
    attributes: (writer) => writer.add('id', 'app-root'),
    child: (writer) => writer.tag(tag: 'app-nav-bar'),
  );

  void writeJsonScript(
    HtmlWordGroupFormatterOptions options,
    List<WordGroupExport> groups,
  ) => tag(
    tag: 'script',
    attributes: (writer) => writer.add('id', 'script-json-data'),
    child: (writer) => {
      writer.variableLine(
        name: 'json_source',
        value: groups.map((e) => e.toJson()).toList().toString(),
      ),
      writer.variableLine(
        name: 'enable_search_field',
        value: (!options.removeSearchField).toString(),
      ),
      writer.textLine(
        'window.enable_search_field = enable_search_field;'
        'window.json_source_data = json_source;',
      ),
    },
  );
}

final class _AssetFiles {
  final List<_AssetEntry> styles;
  final List<_AssetEntry> scripts;

  static $AssetsExportHtmlTemplateGen get _template =>
      Assets.export.htmlTemplate;

  _AssetFiles._({required this.styles, required this.scripts});

  static Future<_AssetFiles> load() async {
    final futures = [
      _loadEntry(
        tag: 'style',
        namePath: {
          'theme': _template.css.theme,
          'main': _template.css.main,
          'components': _template.css.components,
        },
      ),
      _loadEntry(
        tag: 'script',
        namePath: {
          'components': _template.js.components,
          'startup': _template.js.startup,
        },
      ),
    ];

    final entries = await Future.wait(futures);

    return ._(styles: entries[0], scripts: entries[1]);
  }

  static Future<List<_AssetEntry>> _loadEntry({
    required String tag,
    required Map<String, String> namePath,
  }) {
    final futures = namePath.entries.map(
      (pair) async => _AssetEntry(
        name: pair.key,
        content: await rootBundle.loadString(pair.value),
      ),
    );

    return Future.wait(futures);
  }
}

final class _AssetEntry {
  final String name;
  final String content;

  _AssetEntry({required this.name, required this.content});
}
