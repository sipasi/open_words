import 'package:flutter/material.dart';
import 'package:open_words/features/game/quiz_end/widgets/score_progress_indicator.dart';
import 'package:open_words/features/game/shared/quiz/quiz_score.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class ScoreProgressView extends StatelessWidget {
  final QuizScore score;

  const ScoreProgressView({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Text(
                  'Correct: ${score.correct}',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Wrong: ${score.wrongAttempts}',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ScoreProgressIndicator(score: score),
          ],
        ),
      ),
    );
  }
}
