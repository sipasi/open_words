import 'package:flutter/material.dart';
import 'package:open_words/features/game/guess_games/word_pairs/widgets/animated_card/animated_pair_part_card.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class AudioCard extends StatelessWidget {
  final bool readonly;
  final bool selected;

  final int partId;
  final bool isQuestionPart;

  final Function() onTap;

  const AudioCard({
    super.key,
    required this.readonly,
    required this.selected,
    required this.partId,
    required this.isQuestionPart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? context.colorScheme.onPrimary : null;

    return AnimatedPairPartCard(
      disabled: readonly,
      selected: selected,
      partId: partId,
      isQuestionPart: isQuestionPart,
      onTap: onTap,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.audio_file, color: color),
            Icon(Icons.multitrack_audio, color: color),
          ],
        ),
      ),
    );
  }
}
