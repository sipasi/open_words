import 'package:flutter/material.dart';
import 'package:open_words/collection/readonly_list.dart';
import 'package:open_words/view/game/word_compare/choose_result.dart';
import 'package:open_words/view/game/word_compare/word_text_getter.dart';
import 'package:open_words/view/shared/list/adaptive_grid_view.dart';

class CompareResultsPage extends StatelessWidget {
  final IReadonlyList<ChooseResult> results;
  final WordTextGetter textGetter;

  const CompareResultsPage({
    super.key,
    required this.results,
    required this.textGetter,
  });

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
        results.length,
        (index) {
          final item = results[index];

          final question = textGetter.question(item.question);
          final answer = textGetter.answer(item.answer);

          final right = textGetter.answer(item.question);

          return Card.outlined(
            child: _Tile(
              correct: item.correct,
              question: question,
              answer: answer,
              right: right,
            ),
          );
        },
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final bool correct;
  final String question;
  final String answer;
  final String right;

  const _Tile({
    required this.correct,
    required this.question,
    required this.answer,
    required this.right,
  });

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
                Text(right, maxLines: 2, style: correctStyle),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              answer,
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
