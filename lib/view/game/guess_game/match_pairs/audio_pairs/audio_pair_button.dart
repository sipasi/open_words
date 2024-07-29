import 'package:flutter/material.dart';
import 'package:open_words/view/game/guess_game/match_pairs/selectable_button.dart';

class AudioPairButton extends StatelessWidget {
  final bool readonly;
  final bool selected;

  final EdgeInsets margin;
  final Function() onTap;

  const AudioPairButton({
    super.key,
    required this.readonly,
    required this.selected,
    required this.onTap,
    this.margin = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    return SelectableButton(
      disabled: readonly,
      selected: selected,
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
