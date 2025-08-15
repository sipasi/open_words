import 'package:flutter/material.dart';

class ExplorerGridTile extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final Icon icon;
  final Color iconBackground;
  final Widget? trailing;

  final void Function() onTap;
  final void Function() onLongPress;

  const ExplorerGridTile({
    super.key,
    required this.title,
    this.titleStyle,
    required this.icon,
    required this.iconBackground,
    this.trailing,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: titleStyle,
      ),
      leading: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        child: ColoredBox(
          color: iconBackground,
          child: SizedBox(width: 36, height: 36, child: icon),
        ),
      ),
      trailing: trailing,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
