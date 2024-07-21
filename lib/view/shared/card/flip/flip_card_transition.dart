import 'dart:math';

import 'package:flutter/material.dart';
import 'package:open_words/view/shared/card/flip/flip_card.dart';

class FlipCardTransition extends StatefulWidget {
  final Widget face;
  final Widget back;

  /// The [Animation] that controls the flip card
  final Animation<double> animation;

  /// The animation [Axis] of the card
  final Axis direction;

  /// How to align the [face] and [back] in the card
  final Alignment alignment;

  /// The default [faceAnimator]
  static final defaultFaceAnimator = TweenSequence(
    [
      TweenSequenceItem<double>(
        tween: Tween(begin: 0.0, end: pi / 2).chain(
          CurveTween(curve: Curves.easeIn),
        ),
        weight: 50.0,
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(pi / 2),
        weight: 50.0,
      ),
    ],
  );

  /// The default [backAnimator]
  static final defaultBackAnimator = TweenSequence(
    [
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(pi / 2),
        weight: 50.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween(begin: -pi / 2, end: 0.0).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: 50.0,
      ),
    ],
  );

  const FlipCardTransition({
    super.key,
    required this.face,
    required this.back,
    required this.animation,
    this.direction = Axis.horizontal,
    this.alignment = Alignment.center,
  });

  @override
  State<FlipCardTransition> createState() => _FlipCardTransitionState();
}

class _FlipCardTransitionState extends State<FlipCardTransition> {
  late CardSide _side;

  @override
  void initState() {
    super.initState();

    _side = CardSide.fromAnimationStatus(widget.animation.status);

    widget.animation.addStatusListener(_statusListener);
  }

  @override
  void didUpdateWidget(covariant FlipCardTransition oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.animation == oldWidget.animation) {
      return;
    }

    oldWidget.animation.removeStatusListener(_statusListener);

    widget.animation.addStatusListener(_statusListener);

    _side = CardSide.fromAnimationStatus(widget.animation.status);
  }

  @override
  void dispose() {
    super.dispose();
    widget.animation.removeStatusListener(_statusListener);
  }

  void _statusListener(AnimationStatus status) {
    final newSide = CardSide.fromAnimationStatus(status);

    if (newSide == _side) {
      return;
    }

    setState(() => _side = newSide);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.alignment,
      fit: StackFit.passthrough,
      children: [
        _buildContent(child: widget.face),
        _buildContent(child: widget.back),
      ],
    );
  }

  Widget _buildContent({required Widget child}) {
    final isFace = child == widget.face;
    final showingFace = _side == CardSide.face;

    return IgnorePointer(
      ignoring: isFace ? !showingFace : showingFace,
      child: FlipTransition(
        animation: isFace
            ? FlipCardTransition.defaultFaceAnimator.animate(widget.animation)
            : FlipCardTransition.defaultBackAnimator.animate(widget.animation),
        direction: widget.direction,
        child: child,
      ),
    );
  }
}

class FlipTransition extends AnimatedWidget {
  final Widget child;
  final Axis direction;
  final Animation<double> animation;

  const FlipTransition({
    super.key,
    required this.child,
    required this.direction,
    required this.animation,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final transform = Matrix4.identity();

    transform.setEntry(3, 2, 0.001);

    direction == Axis.horizontal ? transform.rotateY(animation.value) : transform.rotateX(animation.value);

    return Transform(
      transform: transform,
      alignment: FractionalOffset.center,
      filterQuality: FilterQuality.none,
      child: child,
    );
  }
}
