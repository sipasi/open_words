import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/export/formatter/export_format.dart';
import 'package:open_words/service/export/formatter/format_options.dart';
import 'package:open_words/service/export/path_factory/folder_location.dart';
import 'package:open_words/service/export/word_group/word_group_export_service.dart';
import 'package:open_words/service/export/word_group/word_group_formatter_factory.dart';
import 'package:open_words/service/share/share_file.dart';
import 'package:open_words/view/shared/dialog/loading_dialog.dart';

class ExportOptionsViewModel {
  static const String _defauldName = 'WordGroups';

  final List<WordGroup> _groups;

  String _name;
  bool _oneFile;
  bool _download;
  FolderLocation _location;
  ExportFormat _format;

  String get name => _name;
  bool get oneFile => _oneFile;
  bool get download => _download;
  FolderLocation get location => _location;
  ExportFormat get format => _format;

  bool get isEmpty => _groups.isEmpty;
  bool get isSingle => _groups.length == 1;
  bool get isMany => _groups.length > 1;

  ExportOptionsViewModel({required List<WordGroup> groups})
      : _groups = groups,
        _name = _defauldName,
        _oneFile = true,
        _download = false,
        _location = FolderLocation.downloads,
        _format = ExportFormat.pdf {
    if (isSingle) {
      _name = groups[0].name;
    }
  }

  void setName(String name) {
    _name = name;
  }

  void switchOneFile() {
    _oneFile = !_oneFile;
  }

  void switchDownload() {
    _download = !_download;
  }

  void selectLocation(FolderLocation? location) {
    if (location == null) {
      return;
    }

    _location = location;
  }

  void selectFormat(ExportFormat? format) {
    if (format == null) {
      return;
    }

    _format = format;
  }

  Future perform(BuildContext context, FormatOptions options) {
    return _download ? _onDownload(context, options) : _onShare(context, options);
  }

  Future _onDownload(BuildContext context, FormatOptions options) {
    final export = GetIt.I.get<WordGroupExportService>();

    final future = export.exportTo(location, _groups, name, format, options);

    return LoadingDialog.show(context: context, future: future);
  }

  Future _onShare(BuildContext context, FormatOptions options) {
    final factory = WordGroupFormatterFactory();

    return ShareFile.shareData(
      context: context,
      data: _groups,
      format: _format,
      formatter: factory.create(_format),
      name: _name,
      options: options,
    );
  }
}
