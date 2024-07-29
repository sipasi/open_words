import 'package:flutter/material.dart';
import 'package:open_words/view/game/game_progress_indicator.dart';
import 'package:open_words/view/game/guess_game/guess_score.dart';

class GuessScoreView extends StatelessWidget {
  final int correct;
  final int wrong;
  final int total;
  final int answered;

  const GuessScoreView({
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

class GuessProgressBar extends StatelessWidget {
  final int total;
  final int answered;
  final int correct;
  final int wrong;

  final double percentage;

  final EdgeInsets margin;

  const GuessProgressBar({
    super.key,
    required this.total,
    required this.answered,
    required this.correct,
    required this.wrong,
    required this.percentage,
    this.margin = const EdgeInsets.all(0),
  });
  GuessProgressBar.fromScore({
    super.key,
    required ReadonlyScore score,
    this.margin = const EdgeInsets.all(0),
  })  : total = score.total,
        answered = score.answered,
        correct = score.correct,
        wrong = score.wrong,
        percentage = score.progressPercentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        children: [
          GameProgressIndicator(percentage: percentage),
          const SizedBox(height: 10),
          GuessScoreView(
            correct: correct,
            wrong: wrong,
            total: total,
            answered: answered,
          ),
        ],
      ),
    );
  }
}
