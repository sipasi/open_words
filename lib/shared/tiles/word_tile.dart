import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class WordTile extends StatelessWidget {
  final String title;
  final String subtitle;

  final Color? titleColor;
  final Color? subtitleColor;

  final void Function()? onTap;

  const WordTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleColor,
    this.subtitleColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: titleColor ?? colorScheme.primary,
                ),
              ),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(
                  color: subtitleColor ?? colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
