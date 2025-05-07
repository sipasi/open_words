import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ArrivedWord extends StatelessWidget {
  final String text;
  final TextStyle style;

  final AnimationController controller;

  const ArrivedWord({
    super.key,
    required this.text,
    required this.style,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: TextAlign.center, style: style)
        .animate(controller: controller)
        .moveX(
          begin: 300,
          end: 0,
          duration: const Duration(milliseconds: 400),
          delay: const Duration(milliseconds: 200),
          curve: Curves.slowMiddle,
        )
        .fade(begin: 0, end: 1);
  }
}
