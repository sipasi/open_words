import 'dart:math';

import 'package:flutter/material.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/word_compare/word_compare_body.dart';
import 'package:open_words/view/game/word_compare/word_compare_score.dart';
import 'package:open_words/view/game/word_compare/word_compare_tool.dart';

class WordCompareGame extends StatefulWidget {
  final List<Word> words;
  final Map<Word, WordMetadata> metadatas;

  const WordCompareGame({
    super.key,
    required this.words,
    required this.metadatas,
  });

  @override
  State<WordCompareGame> createState() => _WordCompareGameState();
}

class _WordCompareGameState extends State<WordCompareGame> {
  final random = Random();

  late final List<Word> words;

  late final int total;

  late List<String> answers;

  int correct = 0, wrong = 0, answered = 0;

  int visibleDefinitions = 0;

  bool get isGameEnd => answered == total;

  @override
  void initState() {
    super.initState();

    total = widget.words.length;

    words = widget.words.toList(growable: false)..shuffle();

    restart();
  }

  @override
  Widget build(BuildContext context) {
    if (isGameEnd) {
      return Column(
        children: [
          WordCompareScore(
            correct: correct,
            wrong: wrong,
            total: total,
            answered: answered,
          ),
          TextButton(
            onPressed: () {
              showGameEndDialog();
            },
            child: const Text('tap'),
          ),
        ],
      );
    }

    final question = words[answered];

    final metadata = widget.metadatas[question];

    return WordCompareBody(
      question: widget.questionText(question),
      answers: answers,
      correct: correct,
      wrong: wrong,
      total: total,
      answered: answered,
      visibleDefinitions: visibleDefinitions,
      helpers: WordCompareTool.helpersFrom(metadata),
      onHelpTap: _onHelpTap,
      onAnswerTap: (word) => _onAnswerTap(word, question),
    );
  }

  void restart() {
    correct = wrong = answered = 0;

    visibleDefinitions = 0;

    words.shuffle();

    generateNewAnswers();
  }

  void generateNewAnswers() {
    answers = WordCompareTool.randomizeAnswers(words[answered], words, widget.answerText);
  }

  void _onHelpTap() {
    setState(() {
      visibleDefinitions++;
    });
  }

  void _onAnswerTap(String answer, Word question) async {
    setState(() {
      answered++;

      visibleDefinitions = 0;

      if (isGameEnd == false) {
        generateNewAnswers();
      }

      if (widget.answerText(question) == answer) {
        correct++;
      } else {
        wrong++;
      }
    });
  }

  Future<T?> showGameEndDialog<T>() {
    return showDialog<T>(
      context: context,
      builder: (builder) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton.icon(
                  icon: const Icon(Icons.info),
                  label: const Text('Info'),
                  onPressed: () {},
                ),
                const SizedBox(height: 10),
                FilledButton.tonalIcon(
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Restart'),
                  onPressed: () {
                    setState(() {
                      restart();
                      Navigator.pop(context);
                    });
                  },
                ),
                const SizedBox(height: 10),
                FilledButton.tonalIcon(
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text('Exit'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
