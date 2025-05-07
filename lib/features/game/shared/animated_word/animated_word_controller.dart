import 'package:flutter/material.dart';

class AnimatedWordController {
  final TickerProvider vsync;

  final AnimationController previousAnimation;
  final AnimationController arrivedAnimation;
  final AnimationController lastAnimation;

  final void Function()? onCorrect;
  final void Function()? onIncorrect;

  Color leavedColor = Colors.transparent;
  bool leavedShake = false;

  AnimatedWordController({
    required this.vsync,
    this.onCorrect,
    this.onIncorrect,
  }) : previousAnimation = AnimationController(
         vsync: vsync,
         duration: Duration.zero,
       ),
       arrivedAnimation = AnimationController(
         vsync: vsync,
         duration: Duration.zero,
       ),
       lastAnimation = AnimationController(
         vsync: vsync,
         duration: Duration.zero,
       );

  void startCorrect() {
    leavedColor = Colors.green;
    leavedShake = false;

    onCorrect?.call();

    _startAnimation();
  }

  void startIncorect() {
    leavedColor = Colors.red;
    leavedShake = true;

    onIncorrect?.call();

    _startAnimation();
  }

  void _startAnimation() {
    previousAnimation.forward(from: 0);
    arrivedAnimation.forward(from: 0);
  }

  void dispose() {
    previousAnimation.dispose();
    arrivedAnimation.dispose();
    lastAnimation.dispose();
  }
}
