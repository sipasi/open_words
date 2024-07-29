import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/view/game/dialog/game_end_dialog.dart';
import 'package:open_words/view/game/view_word_game/flashcard/flashcard.dart';
import 'package:open_words/view/game/view_word_game/flashcard/flashcard_game.dart';
import 'package:open_words/view/game/view_word_game/view_progress_bar.dart';
import 'package:open_words/view/game/word_game_screen.dart';

import 'package:open_words/view/shared/card/flip/flip_card.dart';
import 'package:open_words/view/shared/card/flip/flip_card_controller.dart';

class FlashcardGamePage extends StatefulWidget {
  final WordGroup group;

  final CardSideFiller sideFiller;

  const FlashcardGamePage.origins({super.key, required this.group}) : sideFiller = const CardSideFiller.origin();
  const FlashcardGamePage.translations({super.key, required this.group})
      : sideFiller = const CardSideFiller.translation();

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
      filler: widget.sideFiller,
      onGameEnd: _onGameEnd,
    );

    _game.init();
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.all(20);

    final theme = Theme.of(context);
    final scheem = theme.colorScheme;

    final gameEndOffset = _game.gameEnd ? 1 : 0;

    final position = _game.position + gameEndOffset;

    return Scaffold(
      body: WordGameScreen(
        game: _game,
        onPrev: _onPrev,
        onNext: _onNext,
        progressBuilder: (context) => ViewProgressBar(
          total: _game.allWords,
          position: position,
          percentage: position / _game.allWords,
        ),
        bottomMargin: const EdgeInsets.all(20).copyWith(bottom: 20),
        bodyBuilder: (context) => Expanded(
          child: Padding(
            padding: padding,
            child: Flashcard(
              face: _FlipSideView(side: _game.face, color: scheem.primary),
              back: _FlipSideView(side: _game.back, color: scheem.secondary),
              controller: _controller,
              onTap: _controller.flipOpposite,
            ),
          ),
        ),
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

  Future _onGameEnd() {
    return GameEndDialog.showDelayed(
      context: context,
      onExit: () => MaterialNavigator.pop(context, times: 2),
      onRestart: () {
        setState(() => _game.restart());

        MaterialNavigator.pop(context);
      },
    );
  }
}

class _FlipSideView extends StatelessWidget {
  final String side;
  final Color color;

  const _FlipSideView({required this.side, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: color,
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          side,
          textAlign: TextAlign.center,
          style: style,
        ),
      ),
    );
  }
}
