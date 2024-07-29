import 'package:flutter/material.dart';
import 'package:open_words/view/game/game_progress_indicator.dart';

class ViewProgressBar extends StatelessWidget {
  final int total;
  final int position;

  final double percentage;

  final EdgeInsets margin;

  const ViewProgressBar({
    super.key,
    required this.total,
    required this.position,
    required this.percentage,
    this.margin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final totalStyle = theme.textTheme.titleLarge?.copyWith(color: colorScheme.secondary);

    return Padding(
      padding: margin,
      child: Column(
        children: [
          GameProgressIndicator(percentage: percentage),
          const SizedBox(height: 20),
          Text('$position/$total', style: totalStyle),
        ],
      ),
    );
  }
}
