import 'package:flutter/material.dart';
import 'package:open_words/view/game/answer_record/answer_history.dart';
import 'package:open_words/view/game/answer_record/answer_record.dart';
import 'package:open_words/view/shared/list/adaptive_grid_view.dart';

class AnswerRecordListPage extends StatelessWidget {
  final ReadonlyHistory history;

  const AnswerRecordListPage({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _grid(context),
    );
  }

  Widget _grid(BuildContext context) {
    return AdaptiveGridView(
      padding: const EdgeInsets.all(10),
      maxCrossAxisExtent: 500,
      mainAxisExtent: 110,
      children: List.generate(
        history.length,
        (index) {
          final item = history[index];

          return Card.outlined(child: _Tile.fromAnswer(item));
        },
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final bool correct;
  final String question;
  final String userAnswer;
  final String answer;

  const _Tile({
    required this.correct,
    required this.question,
    required this.userAnswer,
    required this.answer,
  });
  _Tile.fromAnswer(AnswerRecord result)
      : this(
          correct: result.correct,
          question: result.question,
          userAnswer: result.userAnswer,
          answer: result.answer,
        );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final scheme = theme.colorScheme;

    final questionStyle = textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: scheme.onSurface,
      overflow: TextOverflow.ellipsis,
    );
    final correctStyle = textTheme.bodyMedium?.copyWith(
      color: scheme.onSurfaceVariant,
      overflow: TextOverflow.ellipsis,
    );
    final answerStyle = textTheme.labelSmall?.copyWith(
      color: correct ? scheme.primary : scheme.error,
      overflow: TextOverflow.ellipsis,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(question, maxLines: 2, style: questionStyle),
                Text(answer, maxLines: 2, style: correctStyle),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              userAnswer,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.end,
              style: answerStyle,
            ),
          )
        ],
      ),
    );
  }
}
