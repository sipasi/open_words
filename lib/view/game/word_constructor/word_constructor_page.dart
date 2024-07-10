import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/view/game/dialog/game_end_dialog.dart';
import 'package:open_words/view/game/game_progress_indicator.dart';

import 'construct_result_card.dart';
import 'word_constructor_game.dart';
import 'word_part_chips.dart';

class WordConstructorPage extends StatefulWidget {
  final WordGroup group;

  const WordConstructorPage({super.key, required this.group});

  @override
  State<WordConstructorPage> createState() => _WordConstructorPageState();
}

class _WordConstructorPageState extends State<WordConstructorPage> {
  late final WordConstructorGame _game;

  @override
  void initState() {
    super.initState();

    _game = WordConstructorGame(
      words: widget.group.words,
      onCorrectConstructed: _onCorrectConstructed,
      onWrongConstructed: _onWrongConstructed,
      onGameEnd: _onGameEnd,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GameProgressIndicator(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              percentage: _game.constructedPercentage,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_game.current.question} ${_game.current.constructedText}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    WordPartChips(
                      parts: _game.current.answers,
                      onPressed: (id) => setState(() => _game.onAnswerTap(id)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: WordPartChips(
                  parts: _game.current.variants,
                  onPressed: (id) => setState(() => _game.onVariantTap(id)),
                ),
              ),
            ),
            ConstructResultCard(
              construtedText: _game.current.constructedText,
              correct: _game.current.answer,
              matched: _game.current.matched,
              visible: _game.current.constructed,
            ),
            Padding(
              padding: const EdgeInsets.all(10).copyWith(bottom: 30),
              child: Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: () => MaterialNavigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: _game.canNext ? () => setState(() => _game.next()) : null,
                      label: const Text('next'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCorrectConstructed() {}
  void _onWrongConstructed() {}

  Future _onGameEnd() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      await GameEndDialog.show(
        context: context,
        onResults: () {},
        onRestart: () {},
        onExit: () {
          MaterialNavigator.pop(context, times: 2);
        },
      );
    }
  }
}
