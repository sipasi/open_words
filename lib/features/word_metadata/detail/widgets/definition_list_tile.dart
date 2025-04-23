import 'package:flutter/material.dart';
import 'package:open_words/core/data/entities/metadata/definition.dart';
import 'package:open_words/features/word_metadata/detail/widgets/definition_list_tile_part.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class DefinitionListTile extends StatelessWidget {
  final Definition definition;

  const DefinitionListTile({super.key, required this.definition});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return IntrinsicHeight(
      child: Row(
        children: [
          Container(color: colorScheme.primary, width: 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DefinitionListTilePart(
                  title: 'Definition: ',
                  details: definition.value,
                  onTap: () => onDefinitionTap(definition.value),
                  onLongPress: () => onDefinitionLongPress(definition.value),
                ),
                if (definition.example.isNotEmpty)
                  DefinitionListTilePart(
                    title: 'Example: ',
                    details: definition.example,
                    onTap: () => onExampleTap(definition.value),
                    onLongPress: () => onExampleLongPress(definition.value),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onDefinitionTap(String value) {}
  void onDefinitionLongPress(String value) {}
  void onExampleTap(String value) {}
  void onExampleLongPress(String value) {}
}
