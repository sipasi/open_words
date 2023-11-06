import 'package:flutter/material.dart';

class CompareScoreView extends StatelessWidget {
  final int correct;
  final int wrong;
  final int total;
  final int answered;

  const CompareScoreView({
    super.key,
    required this.correct,
    required this.wrong,
    required this.total,
    required this.answered,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final titleLarge = theme.textTheme.titleLarge;

    final correctStyle = titleLarge?.copyWith(color: colorScheme.primary);
    final wrongStyle = titleLarge?.copyWith(color: colorScheme.error);
    final totalStyle = titleLarge?.copyWith(color: colorScheme.secondary);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(text: '$correct', style: correctStyle),
            TextSpan(text: '/', style: titleLarge),
            TextSpan(text: '$wrong', style: wrongStyle),
          ]),
        ),
        Text('$answered/$total', style: totalStyle),
      ],
    );
  }
}
