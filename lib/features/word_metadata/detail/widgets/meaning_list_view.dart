import 'package:flutter/material.dart';
import 'package:open_words/core/data/entities/metadata/meaning.dart';
import 'package:open_words/features/word_metadata/detail/widgets/meaning_list_tile.dart';

class MeaningListView extends StatelessWidget {
  final List<Meaning> meanings;

  const MeaningListView({super.key, required this.meanings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(meanings.length, (index) {
        return Card.outlined(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MeaningListTile(meaning: meanings[index]),
          ),
        );
      }),
    );
  }
}
