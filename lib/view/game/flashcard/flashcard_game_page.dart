import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/view/game/dialog/game_end_dialog.dart';
import 'package:open_words/view/game/flashcard/flashcard.dart';
import 'package:open_words/view/game/flashcard/flashcard_game.dart';
import 'package:open_words/view/game/game_bottom_navigation.dart';
import 'package:open_words/view/game/game_progress_indicator.dart';
import 'package:open_words/view/shared/card/flip/flip_card.dart';
import 'package:open_words/view/shared/card/flip/flip_card_controller.dart';

class FlashcardGamePage extends StatefulWidget {
  final WordGroup group;

  const FlashcardGamePage({super.key, required this.group});

  @override
  State<FlashcardGamePage> createState() => _FlashcardGamePageState();
}

class _FlashcardGamePageState extends State<FlashcardGamePage> {
  late final FlipCardController _controller;

  late final FlashcardGame _game;

  @override
  void initState() {
    super.initState();

    _controller = FlipCardController();

    _game = FlashcardGame(
      words: widget.group.words,
      filler: const CardSideFiller.origin(),
      onGameEnd: () => GameEndDialog.show(
        context: context,
        onExit: _onExit,
        onRestart: _onRestart,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.all(10);

    return Scaffold(
      body: Column(
        children: [
          GameProgressIndicator(percentage: _game.progressPercentage),
          Expanded(
            child: Padding(
              padding: padding,
              child: Flashcard(
                face: Center(child: Text(_game.face)),
                back: Center(child: Text(_game.back)),
                controller: _controller,
                onTap: () => _controller.flip(side: _controller.oppositeSide),
              ),
            ),
          ),
          GameBottomNavigation(
            margin: padding.copyWith(bottom: 30),
            exit: GameIconButton(
              icon: Icons.close,
              onPressed: () => MaterialNavigator.pop(context),
            ),
            prev: GameFilledButton(
              text: 'prev',
              canPressed: _game.canPrev,
              onPressed: _onPrev,
              visible: true,
            ),
            next: GameFilledButton(
              text: _game.last ? 'finish' : 'next',
              canPressed: _game.canNext,
              onPressed: _onNext,
              visible: true,
            ),
          ),
        ],
      ),
    );
  }

  void _onPrev() {
    _controller.flipWithoutAnimation(CardSide.face);

    setState(() => _game.prev());
  }

  void _onNext() {
    _controller.flipWithoutAnimation(CardSide.face);

    setState(() => _game.next());
  }

  void _onExit() {
    MaterialNavigator.pop(context, times: 2);
  }

  void _onRestart() {
    setState(() => _game.restart());

    MaterialNavigator.pop(context);
  }
}
