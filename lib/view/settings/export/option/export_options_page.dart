import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/export/formatter/export_format.dart';
import 'package:open_words/service/export/formatter/format_options.dart';
import 'package:open_words/view/settings/export/option/options_widget.dart';
import 'package:open_words/view/shared/dialog/export_format_list_dialog.dart';
import 'package:open_words/view/shared/dialog/folder_location_list_dialog.dart';

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

  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    viewmodel = ExportOptionsViewModel(groups: widget.groups);

    _nameController.text = viewmodel.name;

    options = {
      ExportFormat.pdf: PdfOptions(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final scheem = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          if (viewmodel.isMany) _oneFileWidget(),
          if (viewmodel.oneFile) _nameWidget(),
          const Divider(height: 40),
          _getDownload(),
          if (viewmodel.download) _folderSelector(scheem),
          const Divider(height: 40),
          _format(scheem),
          _formatOption(),
        ],
      ),
      floatingActionButton: getFab(),
    );
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

  Widget _format(ColorScheme scheme) {
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
          selected: (value) {
            setState(() {
              viewmodel.selectFormat(value);
            });
          },
        );
      },
    );
  }

  Widget _getDownload() {
    return ListTile(
      title: const Text('Save on device'),
      trailing: Switch(
        value: viewmodel.download,
        onChanged: (value) {
          setState(() {
            viewmodel.switchDownload();
          });
        },
      ),
    );
  }

  Widget _folderSelector(ColorScheme scheme) {
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
          selected: (value) {
            setState(() {
              viewmodel.selectLocation(value);
            });
          },
        );
      },
    );
  }

  Widget _oneFileWidget() {
    return ListTile(
      title: const Text('As one file'),
      trailing: Switch(
        value: viewmodel.oneFile,
        onChanged: (value) {
          setState(() {
            viewmodel.switchOneFile();
          });
        },
      ),
    );
  }

  Widget _nameWidget() {
    return ListTile(
      title: TextField(
        controller: _nameController,
        decoration: const InputDecoration(labelText: 'File name', border: OutlineInputBorder()),
        onChanged: viewmodel.setName,
      ),
    );
  }

  Widget getFab() {
    final result = switch (viewmodel.download) {
      true => ('Download', Icons.download_outlined),
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
