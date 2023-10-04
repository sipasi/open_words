import 'package:flutter/material.dart';
import 'package:open_words/view/settings/theme_color_tile.dart';
import 'package:open_words/view/settings/theme_mode_tile.dart';

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
          title: OutlinedButton(child: Text('Import'), onPressed: () {}),
        ),
        ListTile(
          leading: const Icon(Icons.file_upload_outlined),
          title: OutlinedButton(child: const Text('Export'), onPressed: () {}),
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
