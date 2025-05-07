import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PreviousWord extends StatelessWidget {
  final String text;
  final TextStyle style;

  final AnimationController controller;

  final bool shake;

  const PreviousWord({
    super.key,
    required this.text,
    required this.style,
    required this.controller,
    required this.shake,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Text(
      text,
      textAlign: TextAlign.center,
      style: style,
    ).animate(controller: controller);

    shake
        ? widget.shake(duration: const Duration(milliseconds: 200))
        : widget.scale(
          begin: Offset(1.2, 1.2),
          end: Offset(1, 1),
          duration: const Duration(milliseconds: 200),
        );

    widget
        .moveX(
          begin: 0,
          end: -300,
          duration: const Duration(milliseconds: 600),
          delay: const Duration(milliseconds: 200),
          curve: Curves.slowMiddle,
        )
        .fade(begin: 1, end: 0);

    return widget;
  }
}
