import 'package:flutter/material.dart';
import 'package:open_words/view/game/match_pairs/pair_part.dart';
import 'package:open_words/view/game/match_pairs/selectable_button.dart';

class AudioPairButton extends StatelessWidget {
  final PairPart card;
  final EdgeInsets margin;
  final Function() onTap;

  const AudioPairButton({
    super.key,
    required this.card,
    required this.onTap,
    this.margin = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    return SelectableButton(
      disabled: card.answered,
      selected: card.selected,
      margin: margin,
      onTap: onTap,
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.audio_file),
            Icon(Icons.multitrack_audio),
          ],
        ),
      ),
    );
  }
}
