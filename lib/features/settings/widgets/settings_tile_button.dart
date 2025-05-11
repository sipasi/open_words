import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class SettingsTileButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onTap;

  const SettingsTileButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = context.textDefaultStyle.copyWith(
      fontWeight: FontWeight.w600,
      color: context.colorScheme.primary,
    );

    return ListTile(
      leading: Icon(icon),
      title: Text(title, textAlign: TextAlign.center, style: titleStyle),
      onTap: onTap,
    );
  }
}
