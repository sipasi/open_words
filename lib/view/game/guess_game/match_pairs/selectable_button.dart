import 'package:flutter/material.dart';
import 'package:open_words/view/shared/button/rectangle_style.dart';

class SelectableButton extends StatelessWidget {
  final Widget child;

  final bool disabled;
  final bool selected;

  final EdgeInsets margin;

  final void Function() onTap;

  const SelectableButton({
    super.key,
    required this.disabled,
    required this.selected,
    required this.margin,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: 150,
        child: Padding(
          padding: margin,
          child: selected
              ? FilledButton(
                  onPressed: disabled ? null : onTap,
                  style: RectangleStyle.filled(),
                  child: child,
                )
              : OutlinedButton(
                  onPressed: disabled ? null : onTap,
                  style: RectangleStyle.outlined(),
                  child: child,
                ),
        ),
      ),
    );
  }
}
