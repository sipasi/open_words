import 'package:flutter/material.dart';
import 'package:open_words/view/shared/tile/tile_style.dart';

class HeroTextTile extends StatelessWidget {
  final String title;
  final String subtitle;

  final String titleTag;
  final String subtitleTag;

  final void Function() onTap;

  final EdgeInsetsGeometry margin;

  const HeroTextTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.titleTag,
    required this.subtitleTag,
    required this.onTap,
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
            Hero(
              tag: titleTag,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TileStyle.title(context),
              ),
            ),
            const Spacer(),
            Hero(
              tag: subtitleTag,
              child: Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                style: TileStyle.subtitle(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
