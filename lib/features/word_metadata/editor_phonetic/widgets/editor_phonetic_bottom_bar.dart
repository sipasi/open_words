import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/draft/metadata/phonetic_draft.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/word_metadata/editor_phonetic/cubit/editor_phonetic_cubit.dart';
import 'package:open_words/shared/bottom_sheet/editor/editor_bottom_bar.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class EditorPhoneticBottomBar extends StatelessWidget {
  const EditorPhoneticBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditorPhoneticCubit>();

    final canNotSubmit = context.select(
      (EditorPhoneticCubit value) => value.state.canNotSubmit,
    );

    return EditorBottomBar(
      actions: [
        if (bloc.isEdit)
          FilledButton.icon(
            onPressed: () => _onDelete(context),
            icon: Icon(Icons.delete_outline),
            label: Text('Delete'),
          ),
      ],
      onSubmitPressed: canNotSubmit ? null : () => _onSumbit(context),
    );
  }

  void _onSumbit(BuildContext context) {
    final bloc = context.read<EditorPhoneticCubit>();

    if (bloc.state.canNotSubmit) {
      return;
    }

    final entity = PhoneticDraft(
      value: bloc.state.value,
      audio: bloc.state.audio,
    );

    final result =
        bloc.isCreate
            ? CrudResult.created(entity)
            : CrudResult.modified(entity);

    context.popWith(result);
  }

  void _onDelete(BuildContext context) {
    final bloc = context.read<EditorPhoneticCubit>();

    if (bloc.isCreate) {
      return context.pop();
    }

    final entity = PhoneticDraft(
      value: bloc.state.value,
      audio: bloc.state.audio,
    );

    context.popWith(CrudResult.deleted(entity));
  }
}
