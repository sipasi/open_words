import 'package:flutter/material.dart';
import 'package:open_words/theme/theme_switcher.dart';

class TextTile extends StatelessWidget {
  final String title;
  final String subtitle;

  final void Function() onTap;

  final EdgeInsetsGeometry margin;

  const TextTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.margin = const EdgeInsets.all(14.0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mode = ThemeSwitcher.of(context).theme!.mode;

    final themeTitle = theme.textTheme.bodyLarge?.copyWith(
      color: theme.colorScheme.secondary,
      fontWeight: FontWeight.bold,
    );

    final themeSubTitle = theme.textTheme.bodyMedium?.copyWith(
      color: mode == ThemeMode.dark ? Colors.grey[400] : Colors.grey[600],
    );

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: themeTitle,
            ),
            const Spacer(),
            Text(
              subtitle,
              overflow: TextOverflow.ellipsis,
              style: themeSubTitle,
            ),
          ],
        ),
      ),
    );
  }
}
