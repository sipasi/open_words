import 'package:flutter/material.dart';
import 'package:open_words/view/game/word_compare/word_compare_helpers.dart';
import 'package:open_words/view/game/word_compare/word_compare_score.dart';

class WordCompareBody extends StatelessWidget {
  final String question;
  final List<String> answers;

  final List<String> helpers;

  final int correct, wrong, total, answered;

  final int visibleDefinitions;

  final void Function() onHelpTap;

  final void Function(String word) onAnswerTap;

  const WordCompareBody({
    super.key,
    required this.question,
    required this.answers,
    required this.helpers,
    required this.correct,
    required this.wrong,
    required this.total,
    required this.answered,
    required this.visibleDefinitions,
    required this.onAnswerTap,
    required this.onHelpTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final titleLarge = theme.textTheme.titleLarge;
    final titleLargeBold = titleLarge?.copyWith(fontWeight: FontWeight.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WordCompareScore(
          correct: correct,
          wrong: wrong,
          total: total,
          answered: answered,
        ),
        Expanded(
          child: WordCompareHelpers(
            helpers: helpers,
            visibleDefinitions: visibleDefinitions,
            onHelpTap: onHelpTap,
          ),
        ),
        Column(
          children: [
            Text(question, style: titleLargeBold?.copyWith(color: colorScheme.secondary)),
            const SizedBox(height: 20),
            createButtonGrid(colorScheme),
          ],
        )
      ],
    );
  }

  Widget createButtonGrid(ColorScheme colorScheme) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(answers.length, (index) {
        final answer = answers[index];

        return createButton(
          text: answer,
          borderColor: colorScheme.secondary,
          onTap: () => onAnswerTap(answer),
        );
      }),
    );
  }

  Widget createButton({required String text, required Color borderColor, required void Function() onTap}) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        side: BorderSide(width: 2, color: borderColor),
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }
}
