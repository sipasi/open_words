import 'package:flutter/material.dart';
import 'package:open_words/theme/color/color_seed.dart';
import 'package:open_words/theme/theme_storage.dart';
import 'package:open_words/theme/theme_switcher.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/settings/theme/theme_tile_helper.dart';
import 'package:open_words/view/shared/dialog/color_list_dialog.dart';

class ThemeController {
  final UpdateState updateState;

  ThemeMode _mode;
  ColorSeed _seed;

  ThemeMode get mode => _mode;
  ColorSeed get seed => _seed;

  bool get isDark => _mode == ThemeMode.dark;

  ThemeController(this.updateState)
      : _mode = ThemeStorage.modeValue(),
        _seed = ThemeStorage.colorValue();

  Future showColorDialog(BuildContext context) {
    return ColorListDialog.show(
      context: context,
      current: seed,
      selected: (value) => updateState(() {
        if (value == seed) {
          return;
        }

        _seed = value;

        final switcher = ThemeSwitcher.of(context);

        final newTheme = switcher.theme!.copyWith(seed: value);

        ThemeStorage.set(newTheme);

        ThemeTileHelper.setTheme(
          context: context,
          seed: seed,
        );
      }),
    );
  }

  void onModeChanged(BuildContext context, bool value) {
    _mode = value ? ThemeMode.dark : ThemeMode.light;

    ThemeTileHelper.setTheme(
      context: context,
      mode: mode,
    );
  }
}
