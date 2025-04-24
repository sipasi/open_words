import 'package:flutter/material.dart';

class ExplorerGridTile extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final int titleLines;
  final Icon icon;
  final Widget? trailing;

  final void Function() onTap;
  final void Function() onLongPress;

  const ExplorerGridTile({
    super.key,
    required this.title,
    this.titleStyle,
    required this.titleLines,
    required this.icon,
    this.trailing,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        maxLines: titleLines,
        overflow: TextOverflow.ellipsis,
        style: titleStyle,
      ),
      leading: icon,
      trailing: trailing,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
