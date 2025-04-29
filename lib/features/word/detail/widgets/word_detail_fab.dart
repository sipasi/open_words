import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/word/detail/cubit/word_detail_page_cubit.dart';
import 'package:open_words/features/word/edit/word_edit_page.dart';
import 'package:open_words/shared/fab/expandable_fab_default.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class WordDetailFab extends StatelessWidget {
  final _key = GlobalKey<ExpandableFabState>();

  WordDetailFab({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableFabDefault.up(
      fabKey: _key,
      children: [
        FloatingActionButton.extended(
          onPressed: () => _onEdit(context),
          icon: Icon(Icons.edit_outlined),
          label: Text('Edit'),
          heroTag: null,
        ),
        FloatingActionButton.extended(
          onPressed: () => _onDelete(context),
          icon: Icon(Icons.delete_outline),
          label: Text('Delete'),
          backgroundColor: context.colorScheme.errorContainer,
          foregroundColor: context.colorScheme.onErrorContainer,
          heroTag: null,
        ),
      ],
    );
  }

  void _onEdit(BuildContext context) {
    final cubit = context.read<WordDetailPageCubit>();
    final state = cubit.state;
    final origin = state.origin;
    final translation = state.translation;
    final metadata = state.metadata;

    _toggle();

    context.push(
      (context) => WordEditPage(
        id: cubit.wordId,
        origin: origin,
        translation: translation,
        metadata: metadata,
      ),
    );

    cubit.refresh();
  }

  void _onDelete(BuildContext context) {
    _toggle();

    final cubit = context.read<WordDetailPageCubit>();

    context.popWith(CrudResult.deleted(cubit.wordId));
  }

  void _toggle() => _key.currentState?.toggle();
}
