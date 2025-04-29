import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/metadata/definition.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/word_metadata/editor_definition/cubit/editor_definition_cubit.dart';
import 'package:open_words/shared/bottom_sheet/editor/editor_bottom_bar.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class EditorDefinitionBottomBar extends StatelessWidget {
  const EditorDefinitionBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditorDefinitionCubit>();

    final isEdit = bloc.isEdit;

    final canNotSubmit = context.select(
      (EditorDefinitionCubit value) => value.state.canNotSubmit,
    );

    return EditorBottomBar(
      actions: [
        if (isEdit)
          FilledButton.icon(
            onPressed: () => _onDelete(context),
            icon: Icon(Icons.delete_outline),
            label: Text('Delete'),
          ),
      ],
      onSubmitPressed: canNotSubmit ? null : () => _onSubmit(context),
    );
  }

  void _onSubmit(BuildContext context) {
    final bloc = context.read<EditorDefinitionCubit>();

    if (bloc.state.canNotSubmit) {
      return;
    }

    final entity = Definition(
      id: bloc.initial?.id ?? const Id.empty(),
      meaningId: bloc.meaningId,
      value: bloc.state.value,
      example: bloc.state.example,
    );

    final Result<Definition> result =
        bloc.isCreate
            ? CrudResult.created(entity)
            : CrudResult.modified(entity);

    return context.popWith(result);
  }

  void _onDelete(BuildContext context) {
    return context.popWith(
      CrudResult.deleted(context.read<EditorDefinitionCubit>().initial!),
    );
  }
}
