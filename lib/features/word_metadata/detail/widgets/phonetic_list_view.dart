import 'package:flutter/material.dart';
import 'package:open_words/core/data/entities/metadata/phonetic.dart';
import 'package:open_words/features/word_metadata/detail/widgets/phonetic_list_tile.dart';

class PhoneticListView extends StatelessWidget {
  final List<Phonetic> phonetics;

  const PhoneticListView({super.key, required this.phonetics});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: List.generate(phonetics.length, (index) {
          final phonetic = phonetics[index];

          return PhoneticListTile(value: phonetic.value, audio: phonetic.audio);
        }),
      ),
    );
  }
}
