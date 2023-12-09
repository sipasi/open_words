import 'package:flutter/material.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/view/settings/export/export_page.dart';
import 'package:open_words/view/settings/export/import_page.dart';
import 'package:open_words/view/settings/theme/theme_color_tile.dart';
import 'package:open_words/view/settings/theme/theme_mode_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const EdgeInsetsGeometry padding = EdgeInsets.only(top: 10.0);

    final colorScheme = Theme.of(context).colorScheme;

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
            onPressed: () => MaterialNavigator.push(context, (context) => const ImportPage()),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.file_upload_outlined),
          title: OutlinedButton(
            child: const Text('Export'),
            onPressed: () => MaterialNavigator.push(context, (context) => const ExportPage()),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.file_copy_outlined),
          title: OutlinedButton(child: const Text('Add preinstalled'), onPressed: () {}),
        ),
        ListTile(
          leading: const Icon(Icons.delete_outline),
          title: OutlinedButton(
            onPressed: () {},
            child: Text('Delete All', style: TextStyle(color: colorScheme.error)),
          ),
        ),
      ],
    );
  }
}
