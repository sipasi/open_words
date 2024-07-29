import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/view/game/guess_game/guess_game_game_end_dialog.dart';
import 'package:open_words/view/game/guess_game/word_question_side.dart';

import '../word_guess_screen.dart';
import 'word_constructor_game.dart';
import 'word_part_chips.dart';

class WordConstructorPage extends StatefulWidget {
  final WordGroup group;
  final WordQuestionSide questionSide;

  const WordConstructorPage.constructOrigins({super.key, required this.group}) : questionSide = WordQuestionSide.origin;
  const WordConstructorPage.constructTranslations({super.key, required this.group})
      : questionSide = WordQuestionSide.translation;

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
      questionSide: widget.questionSide,
      onGameEnd: () => _game.showGameEndDialogDeleyed(context, setState),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WordGuessScreen(
        game: _game,
        onPrev: () => setState(() => _game.prev()),
        onNext: () => setState(() => _game.next()),
        screenMargin: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 30),
        bodyBuilder: (context) {
          final quiz = _game.currentQuiz;

          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _QuestionAnswerSerction(
                          question: quiz.question,
                          constructedText: quiz.constructedText,
                          correctAnswer: quiz.answer,
                          isConstructed: quiz.constructed,
                          isConstructedCorrect: quiz.matched,
                        ),
                        const SizedBox(height: 20),
                        WordPartChips(
                          parts: quiz.answers,
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
                      parts: quiz.variants,
                      alignment: WrapAlignment.center,
                      onPressed: (id) => setState(() => _game.onVariantTap(id)),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _QuestionAnswerSerction extends StatelessWidget {
  final String question;
  final String constructedText;
  final String correctAnswer;
  final bool isConstructed;
  final bool isConstructedCorrect;

  Color get correctColor => Colors.green[400]!;
  Color get uncorrectColor => Colors.red[400]!;

  const _QuestionAnswerSerction({
    required this.question,
    required this.constructedText,
    required this.correctAnswer,
    required this.isConstructed,
    required this.isConstructedCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titleBold = theme.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );

    final questionStyle = titleBold;
    final constructedStyle = titleBold?.copyWith(
      color: _getConstructedColor(),
    );

    final correctAnswerStyle = titleBold?.copyWith(
      color: correctColor,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(question, style: questionStyle),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: constructedText, style: constructedStyle),
              if (isConstructed && isConstructedCorrect == false) ...[
                TextSpan(text: ' - ', style: titleBold),
                TextSpan(text: correctAnswer, style: correctAnswerStyle),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Color? _getConstructedColor() => isConstructed == false
      ? null
      : isConstructedCorrect
          ? correctColor
          : uncorrectColor;
}
