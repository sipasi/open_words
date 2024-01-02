import 'package:flutter/material.dart';
import 'package:open_words/theme/theme_storage.dart';
import 'package:open_words/view/settings/theme/theme_tile_helper.dart';

class ThemeModeTile extends StatefulWidget {
  const ThemeModeTile({super.key});

  @override
  State<ThemeModeTile> createState() => _ThemeModeTileState();
}

class _ThemeModeTileState extends State<ThemeModeTile> {
  late ThemeMode mode;

  @override
  void initState() {
    super.initState();

    mode = ThemeStorage.modeValue();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Dark'),
      trailing: Switch(
        value: mode == ThemeMode.dark,
        onChanged: (value) {
          setState(() {
            mode = value ? ThemeMode.dark : ThemeMode.light;

            ThemeTileHelper.setTheme(
              context: context,
              mode: mode,
            );
          });
        },
      ),
    );
  }
}
