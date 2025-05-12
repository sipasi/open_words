import 'package:flutter/material.dart';
import 'package:open_words/core/data/entities/metadata/word_metadata.dart';
import 'package:open_words/features/word_metadata/detail/widgets/meaning_list_view.dart';
import 'package:open_words/features/word_metadata/detail/widgets/phonetic_list_view.dart';

class WordMetadataView extends StatelessWidget {
  final WordMetadata metadata;

  const WordMetadataView({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (metadata.etymology.isNotEmpty)
          Card.filled(
            child: ListTile(
              title: Text('Etymology'),
              subtitle: Text(metadata.etymology),
            ),
          ),
        PhoneticListView(phonetics: metadata.phonetics),
        MeaningListView(meanings: metadata.meanings),
      ],
    );
  }
}
