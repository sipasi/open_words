import 'package:flutter/material.dart';
import 'package:open_words/core/data/entities/metadata/definition.dart';
import 'package:open_words/features/word_metadata/detail/widgets/definition_list_tile.dart';

class DefinitionListView extends StatelessWidget {
  final List<Definition> definitions;

  const DefinitionListView({super.key, required this.definitions});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: List.generate(definitions.length, (index) {
        final definition = definitions[index];

        return DefinitionListTile(definition: definition);
      }),
    );
  }
}
