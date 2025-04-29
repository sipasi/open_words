import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:open_words/features/word/create_list/word_list_create_page.dart';
import 'package:open_words/features/word_group/detail/cubit/word_group_detail_cubit.dart';
import 'package:open_words/features/word_metadata/update/word_metadata_update_page.dart';
import 'package:open_words/shared/fab/expandable_fab_default.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class WordGroupDetailFab extends StatelessWidget {
  final _key = GlobalKey<ExpandableFabState>();

  WordGroupDetailFab({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableFabDefault.up(
      fabKey: _key,
      children: [
        FloatingActionButton.extended(
          heroTag: null,
          label: Text('Play'),
          icon: const Icon(Icons.gamepad_outlined),
          onPressed: () => _onPlayGames(context),
        ),
        FloatingActionButton.extended(
          heroTag: null,
          label: Text('Add words'),
          icon: const Icon(Icons.add),
          onPressed: () => _onWordAdd(context),
        ),
        FloatingActionButton.extended(
          heroTag: null,
          label: Text('Update metadata'),
          icon: const Icon(Icons.update),
          onPressed: () => _onUpdateMetadata(context),
        ),
      ],
    );
  }

  void _onPlayGames(BuildContext context) {
    _key.currentState?.toggle();
  }

  Future _onWordAdd(BuildContext context) async {
    _key.currentState?.toggle();

    final bloc = context.read<WordGroupDetailCubit>();

    await context.pushBlocValue(
      bloc,
      (context) => WordListCreatePage(group: bloc.state.group),
    );
  }

  Future _onUpdateMetadata(BuildContext context) async {
    _key.currentState?.toggle();

    final bloc = context.read<WordGroupDetailCubit>();

    await context.push(
      (context) => WordMetadataUpdatePage(
        words: bloc.state.words,
        groupName: bloc.state.group.name,
      ),
    );
  }
}
