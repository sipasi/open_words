import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class BottomSheetChoiceChip extends StatelessWidget {
  final BuildContext context;
  final String text;
  final IconData icon;
  final bool selected;
  final bool interactable;

  final void Function() onTap;

  const BottomSheetChoiceChip({
    super.key,
    required this.context,
    required this.text,
    required this.icon,
    required this.selected,
    required this.interactable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    final primary = selected ? colorScheme.primary : null;
    final onPrimary = selected ? colorScheme.onPrimary : null;

    return ChoiceChip(
      selectedColor: primary,
      avatar: Icon(icon, color: onPrimary),
      label: Text(text, style: TextStyle(color: onPrimary)),
      onSelected: interactable ? (_) => onTap() : null,
      selected: selected,
      showCheckmark: false,
    );
  }
}
