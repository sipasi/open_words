import 'package:flutter/material.dart';
import 'package:open_words/features/game/quiz_end/utils/score_message_builder.dart';
import 'package:open_words/features/game/shared/quiz/quiz_score.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class ScoreMessageView extends StatelessWidget {
  final QuizScore score;

  const ScoreMessageView({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Center(
          child: Text(
            ScoreMessageBuilder.fromScore(score),
            overflow: TextOverflow.fade,
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
