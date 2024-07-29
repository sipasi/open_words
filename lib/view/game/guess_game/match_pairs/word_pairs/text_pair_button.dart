import 'package:flutter/material.dart';

import '../selectable_button.dart';

class TextPairButton extends StatelessWidget {
  final String text;
  final bool readonly;
  final bool selected;

  final Function() onTap;

  final EdgeInsets margin;

  const TextPairButton({
    super.key,
    required this.text,
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
      child: Center(
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
