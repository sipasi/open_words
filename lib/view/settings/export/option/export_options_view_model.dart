import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/export/formatter/export_format.dart';
import 'package:open_words/service/export/formatter/format_options.dart';
import 'package:open_words/service/export/path_factory/folder_location.dart';
import 'package:open_words/service/export/word_group/word_group_export_service.dart';
import 'package:open_words/service/export/word_group/word_group_formatter_factory.dart';
import 'package:open_words/service/share/share_file.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/shared/dialog/loading_dialog.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';

class ExportOptionsViewModel {
  static const String _defauldName = 'WordGroups';

  final List<WordGroup> _groups;

  bool _oneFile;
  bool _download;
  FolderLocation _location;
  ExportFormat _format;

  final UpdateState updateState;
  final TextEditViewModel name;

  bool get oneFile => _oneFile;
  bool get download => _download;
  FolderLocation get location => _location;
  ExportFormat get format => _format;

  bool get isEmpty => _groups.isEmpty;
  bool get isSingle => _groups.length == 1;
  bool get isMany => _groups.length > 1;

  bool get canExportAsManyFiles => isWeb == false && isMany;
  bool get canOnlyDownload => isWeb;

  bool get isWeb => kIsWeb;

  ExportOptionsViewModel({required List<WordGroup> groups, required this.updateState})
      : _groups = groups,
        _oneFile = true,
        _download = kIsWeb ? true : false,
        _location = FolderLocation.downloads,
        _format = ExportFormat.pdf,
        name = TextEditViewModel.text(text: _defauldName) {
    if (isSingle) {
      name.setText(groups[0].name);
    }
  }

  void onNameChange() {
    TextEditViewModel.setErrorIfEmpty(name, updateState);
  }

  void switchOneFile(bool value) {
    updateState(() => _oneFile = value);
  }

  void switchDownload(bool value) {
    updateState(() => _download = value);
  }

  void selectLocation(FolderLocation? value) {
    if (value == null) {
      return;
    }

    updateState(() => _location = value);
  }

  void selectFormat(ExportFormat? value) {
    if (value == null) {
      return;
    }

    updateState(() => _format = value);
  }

  Future perform(BuildContext context, FormatOptions options) {
    if (canOnlyDownload) {
      return _onDownload(context, options);
    }

    return _download ? _onDownload(context, options) : _onShare(context, options);
  }

  Future _onDownload(BuildContext context, FormatOptions options) {
    final export = GetIt.I.get<WordGroupExportService>();

    final future = export.exportTo(location, _groups, name.textTrim, format, options);

    return LoadingDialog.show(context: context, future: future);
  }

  Future _onShare(BuildContext context, FormatOptions options) {
    final factory = WordGroupFormatterFactory();

    return ShareFile.shareData(
      context: context,
      data: _groups,
      format: _format,
      formatter: factory.create(_format),
      name: name.textTrim,
      options: options,
    );
  }
}
