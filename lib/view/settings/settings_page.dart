import 'package:flutter/material.dart';
import 'package:open_words/view/settings/theme/theme_color_tile.dart';
import 'package:open_words/view/settings/theme/theme_mode_tile.dart';

import 'settings_view_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late final SettingsViewModel viewmodel;

  @override
  void initState() {
    super.initState();

    viewmodel = SettingsViewModel(setState);
  }

  @override
  Widget build(BuildContext context) {
    const EdgeInsetsGeometry padding = EdgeInsets.only(top: 10.0);

    return ListView(
      padding: padding,
      children: [
        ThemeModeTile(viewmodel: viewmodel.themeController),
        ThemeColorTile(viewmodel: viewmodel.themeController),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.file_download_outlined),
          title: OutlinedButton(
            child: const Text('Import'),
            onPressed: () => viewmodel.toImport(context),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.file_upload_outlined),
          title: OutlinedButton(
            child: const Text('Export'),
            onPressed: () => viewmodel.toExport(context),
          ),
        ),
      ],
    );
  }
}
