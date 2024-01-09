import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/export/formatter/export_format.dart';
import 'package:open_words/service/export/formatter/format_options.dart';
import 'package:open_words/view/settings/export/option/options_widget.dart';
import 'package:open_words/view/shared/dialog/export_format_list_dialog.dart';
import 'package:open_words/view/shared/dialog/folder_location_list_dialog.dart';
import 'package:open_words/view/shared/text/text_edit_field.dart';

import 'export_options_view_model.dart';
import 'pdf_options.dart';

class ExportOptionsPage extends StatefulWidget {
  final List<WordGroup> groups;

  const ExportOptionsPage({super.key, required this.groups});

  @override
  State<ExportOptionsPage> createState() => _ExportOptionsPageState();
}

class _ExportOptionsPageState extends State<ExportOptionsPage> {
  late final ExportOptionsViewModel viewmodel;
  late final Map<ExportFormat, OptionsWidget> options;

  @override
  void initState() {
    super.initState();

    viewmodel = ExportOptionsViewModel(groups: widget.groups, updateState: setState);

    options = {
      ExportFormat.pdf: PdfOptions(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _NamingSection(viewmodel: viewmodel),
          const Divider(height: 40),
          _DownloadSection(viewmodel: viewmodel),
          const Divider(height: 40),
          _FormatSection(viewmodel: viewmodel, options: options),
        ],
      ),
      floatingActionButton: getFab(),
    );
  }

  Widget getFab() {
    final result = switch (viewmodel) {
      ExportOptionsViewModel(canOnlyDownload: true) => ('Download', Icons.download_outlined),
      ExportOptionsViewModel(download: true) => ('Download', Icons.download_outlined),
      _ => ('Share', Icons.share_outlined),
    };

    return FloatingActionButton.extended(
      label: Text(result.$1),
      icon: Icon(result.$2),
      onPressed: () {
        final widget = options[viewmodel.format];

        if (widget == null) {
          viewmodel.perform(context, FormatOptions.empty());
          return;
        }

        viewmodel.perform(context, widget.getOptions());
      },
    );
  }
}

class _NamingSection extends StatelessWidget {
  final ExportOptionsViewModel viewmodel;

  const _NamingSection({required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    if (viewmodel.canExportAsManyFiles) {
      return Column(
        children: [
          if (viewmodel.isMany) _oneFileSwitch(),
          if (viewmodel.oneFile) _name(),
        ],
      );
    }

    return _name();
  }

  Widget _oneFileSwitch() {
    return ListTile(
      title: const Text('As one file'),
      trailing: Switch(
        value: viewmodel.oneFile,
        onChanged: viewmodel.switchOneFile,
      ),
    );
  }

  Widget _name() {
    return ListTile(
      title: TextEditField(
        viewmodel: viewmodel.name,
        border: const OutlineInputBorder(),
        label: 'File name',
        onChanged: (_) => viewmodel.onNameChange(),
      ),
    );
  }
}

class _DownloadSection extends StatelessWidget {
  final ExportOptionsViewModel viewmodel;

  const _DownloadSection({required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    final scheem = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final bodyLarge = textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold);

    if (viewmodel.canOnlyDownload) {
      return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Web',
                style: bodyLarge?.copyWith(color: scheem.primary),
              ),
              TextSpan(
                text: ' is currently ',
                style: bodyLarge,
              ),
              TextSpan(
                text: 'limited',
                style: bodyLarge?.copyWith(color: scheem.error),
              ),
              TextSpan(
                text: ' to file downloads only',
                style: bodyLarge,
              ),
            ],
          ));
    }

    return Column(
      children: [
        _downloadSwitch(),
        if (viewmodel.download) _folderSelector(context, scheem),
      ],
    );
  }

  Widget _downloadSwitch() {
    return ListTile(
      title: const Text('Save on device'),
      trailing: Switch(
        value: viewmodel.download,
        onChanged: viewmodel.switchDownload,
      ),
    );
  }

  Widget _folderSelector(BuildContext context, ColorScheme scheme) {
    return ListTile(
      title: Text(
        'Folder',
        style: TextStyle(color: scheme.primary),
      ),
      subtitle: Text(viewmodel.location.label),
      leading: const Icon(Icons.folder),
      onTap: () {
        FolderLocationListDialog.show(
          context: context,
          current: viewmodel.location,
          selected: viewmodel.selectLocation,
        );
      },
    );
  }
}

class _FormatSection extends StatelessWidget {
  final Map<ExportFormat, OptionsWidget> options;
  final ExportOptionsViewModel viewmodel;

  const _FormatSection({required this.viewmodel, required this.options});

  @override
  Widget build(BuildContext context) {
    final scheem = Theme.of(context).colorScheme;

    return Column(children: [_format(context, scheem), _formatOption()]);
  }

  Widget _formatOption() {
    final option = options[viewmodel.format];

    if (option == null) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text('Have not options'),
      );
    }

    return option;
  }

  Widget _format(BuildContext context, ColorScheme scheme) {
    return ListTile(
      title: Text(
        viewmodel.format.name,
        style: TextStyle(color: scheme.primary),
      ),
      subtitle: Text('.${viewmodel.format.extension}'),
      leading: const Icon(Icons.file_present),
      onTap: () {
        ExportFormatListDialog.show(
          context: context,
          current: viewmodel.format,
          selected: viewmodel.selectFormat,
        );
      },
    );
  }
}
