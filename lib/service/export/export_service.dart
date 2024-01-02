import 'package:open_words/service/export/formatter/data_formatter_factory.dart';
import 'package:open_words/service/export/formatter/export_format.dart';
import 'package:open_words/service/export/formatter/format_options.dart';
import 'package:path/path.dart' as dart_path;

import 'path_factory/folder_location.dart';
import 'path_factory/path_factory.dart';
import 'save_provider/save_provider.dart';

class ExportService<T> {
  final DataFormatterFactory<T> _factory;
  final PathFactory _path;
  final SaveProvider _save;

  const ExportService(this._factory, this._path, this._save);

  Future exportToDownloads(T data, String name, ExportFormat format, FormatOptions options) {
    return exportTo(FolderLocation.downloads, data, name, format, options);
  }

  Future exportTo(FolderLocation location, T data, String name, ExportFormat format, FormatOptions options) async {
    final formatter = _factory.create(format);

    final path = await toFullPath(location, name, format);

    final formatted = await formatter.format(data, options);

    await _save.save(formatted, path);
  }

  Future<String> toFullPath(FolderLocation location, String name, ExportFormat format) async {
    final path = await _path.local(location);

    final full = dart_path.join(path, '$name.${format.extension}');

    return full;
  }
}
