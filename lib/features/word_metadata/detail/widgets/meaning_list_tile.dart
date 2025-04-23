import 'package:flutter/material.dart';
import 'package:open_words/core/data/entities/metadata/meaning.dart';
import 'package:open_words/features/word_metadata/detail/widgets/definition_list_view.dart';
import 'package:open_words/features/word_metadata/detail/widgets/synonym_antonym_view.dart';
import 'package:open_words/features/word_metadata/detail/widgets/title_with_details_text.dart';

class MeaningListTile extends StatelessWidget {
  final Meaning meaning;

  const MeaningListTile({super.key, required this.meaning});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        TitleWithDetailsText(
          title: 'Part of speech: ',
          details: meaning.partOfSpeech,
        ),

        if (meaning.synonyms.isNotEmpty)
          SynonymAntonymView(groupName: 'Synonyms', values: meaning.synonyms),

        if (meaning.antonyms.isNotEmpty)
          SynonymAntonymView(groupName: 'Antonyms', values: meaning.antonyms),

        if (meaning.definitions.isNotEmpty) Divider(),
        if (meaning.definitions.isNotEmpty)
          DefinitionListView(definitions: meaning.definitions),
      ],
    );
  }
}
