import 'package:flutter/material.dart';
import 'package:open_words/data/metadata/meaning.dart';
import 'package:open_words/view/word/detail/metadata/definition_view.dart';
import 'package:open_words/view/word/detail/metadata/synonym_antonym_view.dart';

class MeaningView extends StatelessWidget {
  final Meaning meaning;

  final Function(String text) onSynonymTap;
  final Function(String text) onSynonymLongPress;
  final Function(String text) onAntonymTap;
  final Function(String text) onAntonymLongPress;

  final Function(String text) onDefinitionTap;
  final Function(String text) onDefinitionLongPress;
  final Function(String text) onExampleTap;
  final Function(String text) onExampleLongPress;

  const MeaningView({
    super.key,
    required this.meaning,
    required this.onSynonymTap,
    required this.onSynonymLongPress,
    required this.onAntonymTap,
    required this.onAntonymLongPress,
    required this.onDefinitionTap,
    required this.onDefinitionLongPress,
    required this.onExampleTap,
    required this.onExampleLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final defaultStyle = DefaultTextStyle.of(context).style;

    TextStyle first = defaultStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    TextStyle other = defaultStyle.copyWith(
      color: colorScheme.secondary,
      fontSize: 16,
    );
    TextStyle otherUnderline = other.copyWith(
      color: colorScheme.tertiary,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Part of speech: ',
                style: first,
              ),
              TextSpan(
                text: meaning.partOfSpeech,
                style: other,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SynonymAntonymView(
          groupName: 'Synonym',
          values: meaning.synonyms,
          firstStyle: first,
          otherStyle: otherUnderline,
          onTap: onSynonymTap,
          onLongPress: onSynonymLongPress,
        ),
        const SizedBox(height: 10),
        SynonymAntonymView(
          groupName: 'Antonym',
          values: meaning.antonyms,
          firstStyle: first,
          otherStyle: otherUnderline,
          onTap: onAntonymTap,
          onLongPress: onAntonymLongPress,
        ),
        const SizedBox(height: 10),
        ...meaning.definitions.map(
          (definition) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DefinitionView(
              definition: definition,
              firstStyle: first,
              otherStyle: other,
              onDefinitionTap: onDefinitionTap,
              onDefinitionLongPress: onDefinitionLongPress,
              onExampleTap: onExampleTap,
              onExampleLongPress: onExampleLongPress,
            ),
          ),
        ),
      ],
    );
  }
}
