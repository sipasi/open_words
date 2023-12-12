import 'package:flutter/material.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/word_compare/compare_data.dart';
import 'package:open_words/view/game/word_compare/compare_score.dart';
import 'package:open_words/view/game/word_compare/helper_text_list.dart';
import 'package:open_words/view/game/word_compare/helper_text_list_view.dart';
import 'package:open_words/view/game/word_compare/compare_score_view.dart';
import 'package:open_words/view/game/word_compare/word_text_getter.dart';
import 'package:open_words/view/shared/layout/adaptive_layout_by_constraints_height.dart';

class CompareBody extends StatelessWidget {
  final CompareData data;

  final WordTextGetter textGetter;

  final HelperTextList helpers;

  final CompareScore score;

  final void Function() onHelpTap;

  final void Function(Word word) onAnswerTap;

  const CompareBody({
    super.key,
    required this.data,
    required this.textGetter,
    required this.helpers,
    required this.score,
    required this.onAnswerTap,
    required this.onHelpTap,
  });

  @override
  Widget build(BuildContext context) {
    return _body1(context);
  }

  Widget _body1(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final titleLarge = theme.textTheme.titleLarge;
    final titleLargeBold = titleLarge?.copyWith(fontWeight: FontWeight.bold);

    return AdaptiveLayoutByConstraintsHeight(
      portrait: (context) {
        return Column(
          children: [
            CompareScoreView(
              correct: score.correct,
              wrong: score.wrong,
              total: score.total,
              answered: score.answered,
            ),
            Expanded(
              child: HelperTextListView(
                helpers: helpers.requested,
                canRequest: helpers.canRequest(),
                onHelpTap: onHelpTap,
              ),
            ),
            Column(
              children: [
                Text(
                  textGetter.question(data.question),
                  style: titleLargeBold?.copyWith(color: colorScheme.secondary),
                ),
                const SizedBox(height: 20),
                createButtonGrid(colorScheme),
              ],
            )
          ],
        );
      },
      landscape: (context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: HelperTextListView(
                      helpers: helpers.requested,
                      canRequest: helpers.canRequest(),
                      onHelpTap: onHelpTap,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: VerticalDivider(),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CompareScoreView(
                    correct: score.correct,
                    wrong: score.wrong,
                    total: score.total,
                    answered: score.answered,
                  ),
                  Text(
                    textGetter.question(data.question),
                    style: titleLargeBold?.copyWith(color: colorScheme.secondary),
                  ),
                  createButtonGrid(colorScheme),
                ],
              ),
            )
          ],
        );
      },
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
      children: List.generate(data.answers.length, (index) {
        final answer = data.answers[index];

        return createButton(
          text: textGetter.answer(answer),
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
