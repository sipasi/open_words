import 'package:flutter/material.dart';
import 'package:open_words/view/shared/tile/tile_style.dart';

class TextTile extends StatelessWidget {
  final String title;
  final String? subtitle;

  final int titleLines;
  final int subtitleLines;

  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  final void Function()? onTap;

  final EdgeInsetsGeometry padding;

  const TextTile({
    super.key,
    required this.title,
    this.subtitle,
    this.titleLines = 2,
    this.subtitleLines = 1,
    this.titleStyle,
    this.subtitleStyle,
    this.onTap,
    this.padding = const EdgeInsets.all(14.0),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              maxLines: titleLines,
              overflow: TextOverflow.ellipsis,
              style: titleStyle ?? TileStyle.title(context),
            ),
            Text(
              subtitle ?? '',
              maxLines: subtitleLines,
              overflow: TextOverflow.ellipsis,
              style: subtitleStyle ?? TileStyle.subtitle(context),
            ),
          ],
        ),
      ),
    );
  }
}
