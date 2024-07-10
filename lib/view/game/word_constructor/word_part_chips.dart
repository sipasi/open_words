import 'package:flutter/material.dart';
import 'package:open_words/view/game/word_constructor/part_list.dart';

class WordPartChips extends StatelessWidget {
  final PartList parts;
  final void Function(int id) onPressed;

  const WordPartChips({super.key, required this.parts, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(
        parts.length,
        (index) {
          final part = parts[index];

          return ActionChip(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            onPressed: part.disabled ? null : () => onPressed(part.id),
            label: Text(part.text),
          );
        },
      ),
    );
  }
}
