import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LastWord extends StatelessWidget {
  final String text;
  final TextStyle style;

  final AnimationController controller;

  final bool shake;

  const LastWord({
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

    return widget;
  }
}
