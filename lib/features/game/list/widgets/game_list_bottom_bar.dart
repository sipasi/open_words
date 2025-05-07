import 'package:flutter/material.dart';
import 'package:open_words/features/game/list/widgets/game_list_words_slider.dart';

class GameListBottomBar extends StatelessWidget {
  const GameListBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ).copyWith(bottom: 18),
          child: GameListWordsSlider(),
        ),
      ],
    );
  }
}
