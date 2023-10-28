import 'package:flutter/material.dart';

class ExpandedTile extends StatelessWidget {
  final Widget title;
  final int titleFlext;

  final Widget subtitle;
  final int subtitleFlext;

  final void Function() onTap;

  final EdgeInsetsGeometry margin;

  const ExpandedTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.titleFlext = 2,
    this.subtitleFlext = 1,
    this.margin = const EdgeInsets.all(14.0),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: titleFlext, child: title),
            Expanded(flex: subtitleFlext, child: subtitle),
          ],
        ),
      ),
    );
  }
}
