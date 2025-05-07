import 'package:flutter/material.dart';
import 'package:open_words/features/game/guess_games/word_pairs/widgets/animated_card/animated_pair_part_card.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class TextCard extends StatelessWidget {
  final String text;
  final bool readonly;
  final bool selected;

  final int partId;
  final bool isQuestionPart;

  final Function() onTap;

  const TextCard({
    super.key,
    required this.text,
    required this.readonly,
    required this.selected,
    required this.partId,
    required this.isQuestionPart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPairPartCard(
      disabled: readonly,
      selected: selected,
      partId: partId,
      isQuestionPart: isQuestionPart,
      onTap: onTap,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? context.colorScheme.onPrimary : null,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
