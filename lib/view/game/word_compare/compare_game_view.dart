import 'package:flutter/material.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/view/game/dialog/game_end_dialog.dart';
import 'package:open_words/view/game/word_compare/compare_body.dart';
import 'package:open_words/view/game/word_compare/compare_game.dart';
import 'package:open_words/view/game/word_compare/compare_results_page.dart';
import 'package:open_words/view/game/word_compare/compare_score_view.dart';
import 'package:open_words/view/game/word_compare/word_text_getter.dart';

class CompareGameView extends StatefulWidget {
  final List<Word> words;
  final Map<Word, WordMetadata> map;
  final WordTextGetter textGetter;

  const CompareGameView({
    super.key,
    required this.words,
    required this.map,
    required this.textGetter,
  });

  @override
  State<CompareGameView> createState() => _CompareGameViewState();
}

class _CompareGameViewState extends State<CompareGameView> {
  late final CompareGame game;

  @override
  void initState() {
    super.initState();

    game = CompareGame(
      words: widget.words,
      map: widget.map,
      textGetter: widget.textGetter,
    );

    game.start();
  }

  @override
  Widget build(BuildContext context) {
    if (game.gameEnd) {
      return _endState();
    }

    return _runState();
  }

  Widget _endState() {
    final score = game.score;

    return Column(
      children: [
        CompareScoreView(
          total: score.total,
          answered: score.answered,
          correct: score.correct,
          wrong: score.wrong,
        ),
        TextButton(
          onPressed: () => _showGameEndDialog(),
          child: const Text('tap'),
        ),
      ],
    );
  }

  Widget _runState() {
    return CompareBody(
      data: game.data,
      score: game.score,
      helpers: game.helpers,
      textGetter: widget.textGetter,
      onHelpTap: _onHelpTap,
      onAnswerTap: (word) => _onAnswerTap(word),
    );
  }

  void _onHelpTap() {
    setState(() {
      game.helpers.request();
    });
  }

  void _onAnswerTap(Word answer) async {
    setState(() {
      game.tryAnwser(answer);

      game.next();
    });
  }

  Future _showGameEndDialog() {
    return GameEndDialog.show(
      context: context,
      onResults: () async {
        await MaterialNavigator.push(
          context,
          (builder) => CompareResultsPage(
            results: game.history,
            textGetter: widget.textGetter,
          ),
        );
      },
      onRestart: () {
        MaterialNavigator.pop(context);
        setState(() {
          game.start();
        });
      },
      onExit: () {
        MaterialNavigator.pop(context);
        MaterialNavigator.pop(context);
      },
    );
  }
}
