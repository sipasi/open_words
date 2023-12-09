import 'package:flutter/material.dart';
import 'package:open_words/theme/color/color_seed.dart';
import 'package:open_words/theme/theme_storage.dart';
import 'package:open_words/theme/theme_switcher.dart';
import 'package:open_words/view/shared/dialog/color_list_dialog.dart';

import 'theme_tile_helper.dart';

class ThemeColorTile extends StatefulWidget {
  const ThemeColorTile({super.key});

  @override
  State<ThemeColorTile> createState() => _ThemeColorTileState();
}

class _ThemeColorTileState extends State<ThemeColorTile> {
  int color = 0;

  @override
  void initState() {
    super.initState();

    color = ThemeStorage.colorValue();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Color'),
      trailing: Icon(
        Icons.color_lens,
        color: ColorSeed.values[color].color,
      ),
      onTap: () async {
        ColorListDialog.show(
          context: context,
          current: ColorSeed.values[color],
          selected: (value) => setState(() {
            color = value.index;

            final switcher = ThemeSwitcher.of(context);

            final newTheme = switcher.theme!.copyWith(seed: value);

            ThemeStorage.set(newTheme);

            ThemeTileHelper.setTheme(
              context: context,
              color: color,
            );
          }),
        );
      },
    );
  }
}
