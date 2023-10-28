import 'package:flutter/material.dart';
import 'package:open_words/theme/theme_switcher.dart';

abstract class TileStyle {
  static TextStyle? title(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.bodyLarge?.copyWith(
      color: theme.colorScheme.secondary,
      fontWeight: FontWeight.bold,
    );

    return style;
  }

  static TextStyle? subtitle(BuildContext context) {
    final theme = Theme.of(context);
    final mode = ThemeSwitcher.of(context).theme!.mode;

    final style = theme.textTheme.bodyMedium?.copyWith(
      color: mode == ThemeMode.dark ? Colors.grey[400] : Colors.grey[600],
    );

    return style;
  }
}
