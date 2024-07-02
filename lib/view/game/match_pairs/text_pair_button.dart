import 'package:flutter/material.dart';
import 'package:open_words/view/game/match_pairs/pair_part.dart';

import 'selectable_button.dart';

class TextPairButton extends StatelessWidget {
  final PairPart card;

  final Function() onTap;

  final EdgeInsets margin;

  const TextPairButton({
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
      child: Center(
        child: Text(card.text, textAlign: TextAlign.center),
      ),
    );
  }
}
