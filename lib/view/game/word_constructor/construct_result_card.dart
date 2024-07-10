import 'package:flutter/material.dart';

class ConstructResultCard extends StatelessWidget {
  final String construtedText;
  final String correct;

  final bool matched;
  final bool visible;

  final Color? correctColor;
  final Color? uncorrectColor;

  Color get _currentColor => matched ? _correctColor : _uncorrectColor;

  Color get _correctColor => correctColor ?? Colors.green[400]!;
  Color get _uncorrectColor => uncorrectColor ?? Colors.red[400]!;

  const ConstructResultCard({
    super.key,
    required this.construtedText,
    required this.correct,
    required this.matched,
    required this.visible,
    this.correctColor,
    this.uncorrectColor,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility.maintain(
      visible: visible,
      child: Card.outlined(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          side: BorderSide(
            width: 6,
            color: _currentColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [getText(context)],
          ),
        ),
      ),
    );
  }

  RichText getText(BuildContext context) {
    final theme = Theme.of(context);

    final text = theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    final correctText = text?.copyWith(color: _correctColor);
    final uncorrectText = text?.copyWith(color: _uncorrectColor);

    if (matched) {
      return RichText(text: TextSpan(text: construtedText, style: text));
    }
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: construtedText, style: uncorrectText),
          TextSpan(text: ' | ', style: text),
          TextSpan(text: correct, style: correctText),
        ],
      ),
    );
  }
}
