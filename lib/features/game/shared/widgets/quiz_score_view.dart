import 'package:flutter/material.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

final class QuizScoreView extends StatelessWidget {
  final QuizScore score;

  const QuizScoreView({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LinearProgressIndicator(value: score.progress),
        _Score(score: score),
      ],
    );
  }
}

class _Score extends StatelessWidget {
  final QuizScore score;

  const _Score({required this.score});

  @override
  Widget build(BuildContext context) {
    final defaultStyle = context.textTheme.titleLarge!.copyWith(
      fontWeight: FontWeight.bold,
      color: context.colorScheme.secondary,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CorrectWrong(score: score, defaultStyle: defaultStyle),
          _TotalScore(score: score, defaultStyle: defaultStyle),
        ],
      ),
    );
  }
}

class _CorrectWrong extends StatelessWidget {
  final QuizScore score;

  final TextStyle defaultStyle;

  const _CorrectWrong({required this.score, required this.defaultStyle});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: [
          TextSpan(
            text: score.correct.toString(),
            style: TextStyle(color: context.colorScheme.primary),
          ),
          TextSpan(text: '/'),
          TextSpan(
            text: score.wrongAttempts.toString(),
            style: TextStyle(color: context.colorScheme.error),
          ),
        ],
      ),
    );
  }
}

class _TotalScore extends StatelessWidget {
  final QuizScore score;

  final TextStyle defaultStyle;

  const _TotalScore({required this.score, required this.defaultStyle});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: [
          TextSpan(text: score.questionsAnswered.toString()),
          TextSpan(text: '/'),
          TextSpan(text: score.totalQuestions.toString()),
        ],
      ),
    );
  }
}
