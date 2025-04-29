import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/metadata/definition.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/word_metadata/editor_definition/editor_definition_bottom_sheet.dart';
import 'package:open_words/features/word_metadata/editor_meaning/cubit/editor_meaning_cubit.dart';
import 'package:open_words/shared/builders/value_builder_extension.dart';

class EditorMeaningDefinitionList extends StatelessWidget {
  const EditorMeaningDefinitionList({super.key});

  @override
  Widget build(BuildContext context) {
    final definitions = context.select(
      (EditorMeaningCubit value) => value.state.definitions,
    );

    return ExpansionTile(
      enabled: definitions.isNotEmpty,
      shape: const Border(),
      expansionAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 500),
      ),
      title: Text(
        'Definitions: ${definitions.isEmpty ? 'empty' : definitions.length}',
      ),
      children: List.generate(
        definitions.length,
        (index) => _card(context, definitions[index]),
      ),
    );
  }

  Card _card(BuildContext context, Definition definition) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: definition.value.isNotEmptyBuilder(Text.new),
        subtitle: definition.example.isNotEmptyBuilder(Text.new),
        onTap: () async {
          final result = await EditorDefinitionBottomSheet.edit(
            context: context,
            definition: definition,
          );

          if (!context.mounted) {
            return;
          }

          result.onModified(
            (value) => context.read<EditorMeaningCubit>().updateDefinition(
              source: definition,
              value: value,
            ),
          );
          result.onDeleted(context.read<EditorMeaningCubit>().removeDefinition);
        },
      ),
    );
  }
}
