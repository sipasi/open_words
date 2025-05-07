import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class GameListTileSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  const GameListTileSection({
    super.key,
    required this.title,
    required this.tiles,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: context.colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ).copyWith(top: 16, bottom: 16),
              child: Text(
                title,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.secondary,
                ),
              ),
            ),
          ),
          ...tiles,
        ],
      ),
    );
  }
}
