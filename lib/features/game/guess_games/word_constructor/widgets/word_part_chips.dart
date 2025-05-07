import 'package:flutter/material.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_part.dart';

class WordPartChips extends StatelessWidget {
  final List<WordPart> parts;

  final bool readonly;

  final bool elevated;
  final WrapAlignment alignment;

  final void Function(WordPart part) onTap;

  final bool Function(WordPart part)? isDisabled;

  const WordPartChips({
    super.key,
    required this.parts,
    required this.onTap,
    this.readonly = false,
    this.elevated = false,
    this.isDisabled,
    this.alignment = WrapAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: alignment,
      spacing: 16,
      runSpacing: 16,
      children: List.generate(parts.length, (index) {
        final part = parts[index];
        final disabled = readonly || (isDisabled?.call(part) ?? false);

        final builder = elevated ? ActionChip.elevated : ActionChip.new;

        return builder(
          onPressed: disabled ? null : () => onTap(part),
          label: Text(part.text),
        );
      }),
    );
  }
}
