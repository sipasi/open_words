import 'package:flutter/material.dart';
import 'package:open_words/features/game/shared/animated_word/animated_word_controller.dart';
import 'package:open_words/features/game/shared/animated_word/arrived_word.dart';
import 'package:open_words/features/game/shared/animated_word/last_word.dart';
import 'package:open_words/features/game/shared/animated_word/previous_word.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class AnimatedWordSwitcher extends StatelessWidget {
  final AnimatedWordController controller;

  final String arrivedWord;
  final String? previousWord;
  final bool lastWord;

  final Alignment alignment;

  const AnimatedWordSwitcher({
    super.key,
    required this.controller,
    required this.arrivedWord,
    this.previousWord,
    required this.lastWord,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = context.textTheme.titleLarge!.copyWith(
      fontWeight: FontWeight.bold,
    );

    final canShowPrevious = !lastWord && previousWord != null;

    return Stack(
      alignment: alignment,
      children: [
        if (canShowPrevious)
          PreviousWord(
            text: previousWord!,
            shake: controller.leavedShake,
            style: defaultStyle.copyWith(color: controller.leavedColor),
            controller: controller.previousAnimation,
          ),

        if (!lastWord)
          ArrivedWord(
            text: arrivedWord,
            style: defaultStyle,
            controller: controller.arrivedAnimation,
          ),

        if (lastWord)
          LastWord(
            text: arrivedWord,
            style: defaultStyle.copyWith(color: controller.leavedColor),
            controller: controller.lastAnimation,
            shake: controller.leavedShake,
          ),
      ],
    );
  }
}
