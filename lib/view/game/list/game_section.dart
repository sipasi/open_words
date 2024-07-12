import 'package:flutter/material.dart';
import 'package:open_words/view/shared/list/adaptive_grid_view.dart';

class GameSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  const GameSection({super.key, required this.title, required this.tiles});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titleStyle = theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: titleStyle),
        const SizedBox(height: 10),
        AdaptiveGridView(
          maxCrossAxisExtent: 360,
          mainAxisExtent: 110,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: tiles,
        ),
      ],
    );
  }
}
