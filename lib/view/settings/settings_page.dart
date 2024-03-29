import 'package:flutter/material.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/settings/theme/theme_color_tile.dart';
import 'package:open_words/view/settings/theme/theme_mode_tile.dart';

import 'settings_view_model.dart';

class SettingsPage extends StatefulView<SettingsViewModel> {
  const SettingsPage({super.key});

  @override
  ViewState<SettingsViewModel> createState() => SettingsPageState();
}

class SettingsPageState extends ViewState<SettingsViewModel> {
  @override
  Widget success(BuildContext context) {
    const EdgeInsetsGeometry padding = EdgeInsets.only(top: 10.0);

    return ListView(
      padding: padding,
      children: [
        const ThemeModeTile(),
        const ThemeColorTile(),
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
