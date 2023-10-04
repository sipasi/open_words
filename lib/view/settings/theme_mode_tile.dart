import 'package:flutter/material.dart';
import 'package:open_words/theme/theme_storage.dart';
import 'package:open_words/view/settings/theme_tile_helper.dart';

class ThemeModeTile extends StatefulWidget {
  const ThemeModeTile({super.key});

  @override
  State<ThemeModeTile> createState() => _ThemeModeTileState();
}

class _ThemeModeTileState extends State<ThemeModeTile> {
  int mode = 0;

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
        value: mode == 0,
        onChanged: (value) {
          setState(() {
            mode = value ? 0 : 1;

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
