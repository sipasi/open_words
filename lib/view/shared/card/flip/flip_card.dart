import 'dart:async';

import 'package:flutter/material.dart';
import 'package:open_words/view/shared/card/flip/flip_card_transition.dart';

import 'flip_card_controller.dart';

class FlipCard extends StatefulWidget {
  final Widget face;
  final Widget back;

  final Alignment alignment;

  final Axis direction;
  final Duration duration;

  final CardSide initialSide;

  final FlipCardController? controller;

  final void Function()? onFlip;
  final void Function(CardSide side)? onFlipDone;

  const FlipCard({
    super.key,
    required this.face,
    required this.back,
    this.alignment = Alignment.center,
    this.direction = Axis.horizontal,
    this.duration = const Duration(milliseconds: 500),
    this.initialSide = CardSide.face,
    this.controller,
    this.onFlip,
    this.onFlipDone,
  });

  @override
  State<FlipCard> createState() => FlipCardState();
}

class FlipCardState extends State<FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void didUpdateWidget(covariant FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      controller.duration = widget.duration;
    }

    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller?.state == this) {
        oldWidget.controller?.state = null;
      }

      widget.controller?.state = this;
    }
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      value: widget.initialSide == CardSide.face ? 0 : 1,
      duration: widget.duration,
      vsync: this,
    );

    widget.controller?.state = this;
  }

  @override
  void dispose() {
    controller.dispose();

    widget.controller?.state = null;

    super.dispose();
  }

  Future flip([CardSide? side]) async {
    if (!mounted) {
      return;
    }

    widget.onFlip?.call();

    side ??= getOppositeSide();

    final future = side == CardSide.face ? controller.reverse() : controller.forward();

    await future.complete;

    widget.onFlipDone?.call(side);
  }

  void flipWithoutAnimation([CardSide? side]) {
    controller.stop();
    widget.onFlip?.call();

    side ??= getOppositeSide();

    controller.value = side == CardSide.face ? 0 : 1;

    widget.onFlipDone?.call(side);
  }

  /// Return the opposite side from the side currently being shown
  CardSide getOppositeSide() {
    return CardSide.fromAnimationStatus(controller.status).opposite;
  }

  @override
  Widget build(BuildContext context) {
    final child = FlipCardTransition(
      face: widget.face,
      back: widget.back,
      animation: controller,
      direction: widget.direction,
      alignment: widget.alignment,
    );

    if (widget.controller == null) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: flip,
        child: child,
      );
    }

    return child;
  }
}

enum CardSide {
  face,
  back;

  /// Return [CardSide] associated with the [AnimationStatus]
  factory CardSide.fromAnimationStatus(AnimationStatus status) {
    if (status case AnimationStatus.dismissed || AnimationStatus.reverse) {
      return CardSide.face;
    }

    return CardSide.back;
  }

  CardSide get opposite => switch (this) {
        CardSide.face => CardSide.back,
        CardSide.back => CardSide.face,
      };
}

extension on TickerFuture {
  /// Wait until ticker completes or an error is thrown
  Future<void> get complete {
    final completer = Completer();

    void thunk(value) {
      completer.complete();
    }

    orCancel.then(thunk, onError: thunk);

    return completer.future;
  }
}
