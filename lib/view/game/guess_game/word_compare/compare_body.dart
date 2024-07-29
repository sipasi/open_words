import 'package:flutter/material.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/guess_game/word_compare/compare_game.dart';
import 'package:open_words/view/game/guess_game/word_compare/helper_text_list.dart';
import 'package:open_words/view/game/guess_game/word_compare/helper_text_list_view.dart';

import '../word_guess_screen.dart';
import 'compare_quiz_item.dart';

class CompareBody extends StatelessWidget {
  final CompareGame game;

  final HelperTextList helpers;

  final void Function() onHelpTap;

  final void Function() onPrevTap;
  final void Function() onNextTap;

  final void Function(Word word, int index) onAnswerTap;

  const CompareBody({
    super.key,
    required this.game,
    required this.helpers,
    required this.onAnswerTap,
    required this.onPrevTap,
    required this.onNextTap,
    required this.onHelpTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final titleLarge = theme.textTheme.titleLarge;
    final titleLargeBold = titleLarge?.copyWith(fontWeight: FontWeight.bold);

    return WordGuessScreen(
      game: game,
      bottomMargin: const EdgeInsets.only(top: 20),
      screenMargin: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 30),
      bodyBuilder: (context) {
        return Column(
          children: [
            Center(
              child: Text(
                game.currentQuiz.getQuestionText(),
                style: titleLargeBold?.copyWith(color: colorScheme.secondary),
              ),
            ),
            const SizedBox(height: 20),
            _VariantsGrid(quiz: game.currentQuiz, onTap: onAnswerTap),
          ],
        );
      },
      helpersBuilder: (context) {
        return Expanded(
          child: HelperTextListView(
            helpers: helpers.requested,
            canRequest: helpers.canRequest(),
            onHelpTap: onHelpTap,
          ),
        );
      },
      landscapeDividerBuilder: (context) {
        return const VerticalDivider();
      },
      onPrev: onPrevTap,
      onNext: onNextTap,
    );
  }
}

class _VariantsGrid extends StatelessWidget {
  final CompareQuizItem quiz;

  final void Function(Word word, int index) onTap;

  const _VariantsGrid({required this.quiz, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(quiz.variants.length, (index) {
        final word = quiz.variants[index];

        return createButton(
          text: quiz.getVariantTextAt(index),
          borderColor: colorScheme.secondary,
          onTap: quiz.allSolved ? null : () => onTap(word, index),
        );
      }),
    );
  }

  Widget createButton({required String text, required Color borderColor, required void Function()? onTap}) {
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
