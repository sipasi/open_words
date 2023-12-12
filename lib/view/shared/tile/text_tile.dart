import 'package:flutter/material.dart';
import 'package:open_words/view/shared/tile/tile_style.dart';

class TextTile extends StatelessWidget {
  final String title;
  final String subtitle;

  final int titleLines;
  final int subtitleLines;

  final void Function() onTap;

  final EdgeInsetsGeometry padding;

  const TextTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleLines = 2,
    this.subtitleLines = 1,
    required this.onTap,
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
              style: TileStyle.title(context),
            ), 
            Text(
              subtitle,
              maxLines: subtitleLines,
              overflow: TextOverflow.ellipsis,
              style: TileStyle.subtitle(context),
            ),
          ],
        ),
      ),
    );
  }
}
