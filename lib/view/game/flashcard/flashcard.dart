import 'package:flutter/material.dart';
import 'package:open_words/view/shared/card/flip/flip_card.dart';
import 'package:open_words/view/shared/card/flip/flip_card_controller.dart';

class Flashcard extends StatelessWidget {
  final Widget face;
  final Widget back;

  final void Function() onTap;

  final FlipCardController controller;

  const Flashcard({
    super.key,
    required this.face,
    required this.back,
    required this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: FlipCard(
        controller: controller,
        face: Card.filled(
          child: face,
        ),
        back: Card.filled(
          child: back,
        ),
      ),
    );
  }
}
