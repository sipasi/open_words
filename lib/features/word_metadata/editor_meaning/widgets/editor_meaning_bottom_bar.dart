import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/word_metadata/editor_definition/editor_definition_bottom_sheet.dart';
import 'package:open_words/features/word_metadata/editor_meaning/cubit/editor_meaning_cubit.dart';
import 'package:open_words/features/word_metadata/editor_meaning/utils/editor_meaning_mapper.dart';
import 'package:open_words/shared/bottom_sheet/editor/editor_bottom_bar.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class EditorMeaningBottomBar extends StatelessWidget {
  const EditorMeaningBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isEdit = context.read<EditorMeaningCubit>().isEdit;

    final canNotSubmit = context.select(
      (EditorMeaningCubit value) => value.state.canNotSubmit,
    );

    return EditorBottomBar(
      actions: [
        if (isEdit)
          FilledButton.icon(
            onPressed: () => _onDelete(context),
            icon: Icon(Icons.delete_outline),
            label: Text('Delete'),
          ),
        FilledButton.icon(
          onPressed: () => _onAddDefiniton(context),
          icon: Icon(Icons.add),
          label: Text('Add'),
        ),
      ],
      onSubmitPressed: canNotSubmit ? null : () => _onSumbit(context),
    );
  }

  void _onAddDefiniton(BuildContext context) async {
    final result = await EditorDefinitionBottomSheet.create(
      context: context,
      meaningId: context.read<EditorMeaningCubit>().meaningId,
    );

    if (!context.mounted) {
      return;
    }

    result.onCreated(context.read<EditorMeaningCubit>().addDefinition);
  }

  void _onSumbit(BuildContext context) {
    final bloc = context.read<EditorMeaningCubit>();

    if (bloc.state.canNotSubmit) {
      return;
    }

    final entity = EditorMeaningMapper.fromCubit(bloc);

    final result =
        bloc.isCreate
            ? CrudResult.created(entity)
            : CrudResult.modified(entity);

    context.popWith(result);
  }

  void _onDelete(BuildContext context) {
    final bloc = context.read<EditorMeaningCubit>();

    if (bloc.isCreate) {
      return context.pop();
    }

    context.popWith(CrudResult.deleted(bloc.initial!));
  }
}
