import 'dart:math';

import 'package:flutter/material.dart';
import 'package:open_words/data/metadata/definition.dart';
import 'package:open_words/data/metadata/meaning.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/word_compare_score.dart';

class WordCompareGame extends StatefulWidget {
  final List<Word> words;
  final Map<Word, WordMetadata> metadatas;

  final String Function(Word word) wordText;
  final String Function(Word word) buttonText;

  const WordCompareGame({
    super.key,
    required this.words,
    required this.metadatas,
    required this.wordText,
    required this.buttonText,
  });

  @override
  State<WordCompareGame> createState() => _WordCompareGameState();
}

class _WordCompareGameState extends State<WordCompareGame> {
  final random = Random();

  int correct = 0, wrong = 0, total = 0, answered = 0;

  @override
  void initState() {
    super.initState();

    total = widget.words.length;
  }

  @override
  Widget build(BuildContext context) {
    final words = widget.words;

    final question = words[answered];

    final answers = WordCompareTool.getRandomAnswers(question, words, widget.buttonText);

    final metadata = WordCompareTool.getRandomMetadata();

    return WordCompareBody(
      question: widget.wordText(question),
      answers: answers,
      correct: correct,
      wrong: wrong,
      total: total,
      answered: answered,
      helpers: WordCompareTool.helpersFrom(metadata),
      onAnswerTap: (word) => _onAnswerTap(word, question),
    );
  }

  void _onAnswerTap(String answer, Word question) {
    setState(() {
      answered++;

      if (widget.buttonText(question) == answer) {
        correct++;
      } else {
        wrong++;
      }
    });
  }
}

class WordCompareTool {
  static List<String> helpersFrom(
    WordMetadata? metadata, {
    int definitionCount = 2,
    int synonymsCount = 2,
    int antonymsCount = 2,
  }) {
    if (metadata == null) {
      return List.empty();
    }

    final definitions = metadata.meanings
        .expand((element) => element.definitions.map((e) => e.value))
        .toList(growable: false)
      ..shuffle();

    final synonyms = metadata.meanings.expand((element) => element.synonyms).toList(growable: false)..shuffle();

    final antonyms = metadata.meanings.expand((element) => element.antonyms).toList(growable: false)..shuffle();

    final helpers = <String>[];

    helpers.addAll(definitions.take(definitionCount));
    helpers.addAll(synonyms.take(synonymsCount));
    helpers.addAll(antonyms.take(antonymsCount));

    helpers.shuffle();

    return helpers;
  }

  static WordMetadata getRandomMetadata() {
    return WordMetadata(
      id: 'id',
      word: 'word',
      phonetics: List.empty(),
      meanings: List.generate(
        5,
        (index) => Meaning(
          partOfSpeech: 'partOfSpeech',
          definitions: [
            Definition(
              value: 'Aute id sunt sunt eu nostrud sit velit ex aute est ad.',
            ),
            Definition(
              value: 'Excepteur aliqua laborum voluptate consequat do.',
            ),
            Definition(
              value:
                  'Aliqua incididunt nostrud commodo cupidatat nostrud enim irure adipisicing consequat reprehenderit irure nostrud.',
            ),
          ],
          synonyms: ['synonyms $index'],
          antonyms: ['antonyms $index'],
        ),
      ),
    );
  }

  static List<String> getRandomAnswers(Word question, List<Word> words, String Function(Word word) text) {
    final randoms = words.getRandom(count: 4, exclude: question);

    return randoms.map((e) => text(e)).toList(growable: false);
  }
}

extension WordListRandomExtension on List<Word> {
  static final Random _random = Random();

  List<Word> getRandom({required int count, Word? exclude}) {
    final randoms = <Word>[];

    if (count >= length) {
      return List.empty();
    }

    if (exclude != null) {
      randoms.add(exclude);
    }

    int repeat = 0;

    while (randoms.length != count) {
      int index = _random.nextInt(length);

      Word word = this[index];

      if (repeat++ == 500) {
        break;
      }

      if (randoms.contains(word)) {
        continue;
      }

      randoms.add(word);
    }

    return randoms..shuffle();
  }
}

class WordCompareBody extends StatelessWidget {
  final String question;
  final List<String> answers;

  final List<String> helpers;

  final int correct, wrong, total, answered;

  final void Function(String word) onAnswerTap;

  const WordCompareBody({
    super.key,
    required this.question,
    required this.answers,
    required this.helpers,
    required this.onAnswerTap,
    required this.correct,
    required this.wrong,
    required this.total,
    required this.answered,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final titleLarge = theme.textTheme.titleLarge;
    final titleLargeBold = titleLarge?.copyWith(fontWeight: FontWeight.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WordCompareScore(
          correct: correct,
          wrong: wrong,
          total: total,
          answered: answered,
        ),
        Expanded(
          child: WordCompareHelpers(
            helpers: helpers,
          ),
        ),
        Column(
          children: [
            Text(question, style: titleLargeBold?.copyWith(color: colorScheme.secondary)),
            const SizedBox(height: 20),
            createButtonGrid(colorScheme),
          ],
        )
      ],
    );
  }

  Widget createButtonGrid(ColorScheme colorScheme) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(answers.length, (index) {
        final answer = answers[index];

        return createButton(
          text: answer,
          borderColor: colorScheme.secondary,
          onTap: () => onAnswerTap(answer),
        );
      }),
    );
  }

  Widget createButton({required String text, required Color borderColor, required void Function() onTap}) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        side: BorderSide(width: 2, color: borderColor),
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }
}

class WordCompareHelpers extends StatefulWidget {
  final List<String> helpers;

  const WordCompareHelpers({
    super.key,
    required this.helpers,
  });

  @override
  State<WordCompareHelpers> createState() => _WordCompareHelpersState();
}

class _WordCompareHelpersState extends State<WordCompareHelpers> {
  int visibleDefinitions = 0;

  @override
  Widget build(BuildContext context) {
    final helpers = widget.helpers;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: visibleDefinitions,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final definition = helpers[index];

              return Text(definition, style: TextStyle(color: Theme.of(context).colorScheme.secondary));
            },
          ),
        ),
        if (canLoad())
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Help'),
                    SizedBox(width: 4),
                    Icon(Icons.help_outline),
                  ],
                ),
                onPressed: () => setState(() => visibleDefinitions++)),
          ),
      ],
    );
  }

  bool canLoad() {
    return visibleDefinitions != widget.helpers.length;
  }
}
