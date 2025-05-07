import 'package:flutter/material.dart';
import 'package:open_words/features/game/shared/quiz/quiz_score.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class ScoreProgressIndicator extends StatelessWidget {
  const ScoreProgressIndicator({super.key, required this.score});

  final QuizScore score;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          (score.correctAccuracy * 100).toStringAsFixed(0),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        CircularProgressIndicator(value: 1, color: Colors.red),
        CircularProgressIndicator(value: score.correctAccuracy, color: Colors.green),
      ],
    );
  }
}
